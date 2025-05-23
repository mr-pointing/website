---
aliases:
  - python
draft: false
tags:
  - computerscience
  - youtube
  - python
title: You Can Do Really Cool Things With Functions in Python
date: 2024-07-15
---
Modified: July 15 2024 

[Link](https://www.youtube.com/watch?v=ph2HjBQuI8Y&list=PLU-P2PlzpIf3EpWfxk-Mu_ZVJVS5Wb-_e&index=35) to video.

-------------------------------------------------------------------------------

This video goes over some uncommon ways to use functions in Python. It uses the following code as a base:

```python
"""  
main.py 
"""  
import statistics  
from dataclasses import dataclass  
from typing import Protocol  
from exchange import Exchange  
  
class TradingStrategy(Protocol):  
    """Trading strategy that decides whether to buy or sell, given a list of prices"""  
  
    def should_buy(self, prices: list[int]) -> bool:  
        raise NotImplementedError()  
  
    def should_sell(self, prices: list[int]) -> bool:  
        raise NotImplementedError()  
  
class AverageTradingStrategy:  
    """Trading strategy based on price averages."""  
  
    def should_buy(self, prices: list[int]) -> bool:  
        list_window = prices[-3:]  
        return prices[-1] < statistics.mean(list_window)  
  
    def should_sell(self, prices: list[int]) -> bool:  
        list_window = prices[-3:]  
        return prices[-1] > statistics.mean(list_window)  
  
class MinMaxTradingStrategy:  
    """Trading strategy based on price minima and maxima."""  
  
    def should_buy(self, prices: list[int]) -> bool:  
        # buy if it's below $32,000  
        return prices[-1] < 32_000_00  
  
    def should_sell(self, prices: list[int]) -> bool:  
        # sell if it's above $33,000  
        return prices[-1] > 33_000_00  
  
@dataclass  
class TradingBot:  
    """Trading bot that connects to a crypto exchange and performs trades."""  
  
    exchange: Exchange  
    trading_strategy: TradingStrategy  
  
    def run(self, symbol: str) -> None:  
        prices = self.exchange.get_market_data(symbol)  
        should_buy = self.trading_strategy.should_buy(prices)  
        should_sell = self.trading_strategy.should_sell(prices)  
        if should_buy:  
            self.exchange.buy(symbol, 10)  
        elif should_sell:  
            self.exchange.sell(symbol, 10)  
        else:  
            print(f'No action required for {symbol}.')  
  
def main() -> None:  
    # Creates the exchange and connects to it  
    exchange = Exchange()  
    exchange.connect()  
  
    # create the trading strategy  
    trading_strategy = AverageTradingStrategy()  
  
    # create the trading bot and run the bot once  
    bot = TradingBot(exchange, trading_strategy)  
    bot.run('BTC/USD')  
  
if __name__ == '__main__':  
    main()
```

```python
"""
exchange.py
"""
PRICE_DATA = {  
    "BTC/USD": [  
        35_842_00,  
        34_069_00,  
        33_871_00,  
        34_209_00,  
        32_917_00,  
        33_931_00,  
        33_370_00,  
        34_445_00,  
        32_901_00,  
        33_013_00,  
    ],  
    "ETH/USD": [  
        2_381_00,  
        2_233_00,  
        2_300_00,  
        2_342_00,  
        2_137_00,  
        2_156_00,  
        2_103_00,  
        2_165_00,  
        2_028_00,  
        2_004_00,  
    ],  
}  
  
class ExchangeConnectionError(Exception):  
    """Custom error that is raised when an exchange connection fails."""  
  
class Exchange:  
    def __init__(self) -> None:  
        self.connected = False  
  
    def connect(self) -> None:  
        """Connects to the exchange."""  
        print("Connecting to Crypto Bullshit...")  
        self.connected = True  
  
    def check_connection(self) -> None:  
        """Checks if the exchange is connected."""  
        if not self.connected:  
            raise ExchangeConnectionError("Exchange is not connected dummy.")  
  
    def get_market_data(self, symbol: str) -> list[int]:  
        """Returns fake market price for data given a market symbol."""  
        self.check_connection()  
        return PRICE_DATA[symbol]  
  
    def buy(self, symbol: str, amount: int) -> None:  
        """Simulate buying an amount of a given symbol at current price."""  
        self.check_connection()  
        print(f'Buying amount {amount} in market {symbol}.')  
  
    def sell(self, symbol: str, amount: int) -> None:  
        """Simulate selling an amount of a given symbol at current price."""  
        self.check_connection()  
        print(f'Selling amount {amount} in market {symbol}.')
```

Functions can replicate or even replace code that is heavily reliant on classes. As we see in the code above, the structure is built off of a base `TradingStrategy()` class, and is used/reference many times.

We can rebuild the previous example like so:

```python
"""  
main.py with functions instead of classes 
"""  
import statistics  
from dataclasses import dataclass  
from typing import Callable, Protocol  
from exchange import Exchange  
  
TradingStrategyFunction = Callable[list[int], bool]  
  
def should_buy_avg(prices: list[int]) -> bool:  
    list_window = prices[-3:]  
    return prices[-1] < statistics.mean(list_window)  
  
def should_sell_avg(prices: list[int]) -> bool:  
    list_window = prices[-3:]  
    return prices[-1] > statistics.mean(list_window)  
  
  
def should_buy_minmax(prices: list[int]) -> bool:  
    # buy if it's below $32,000  
    return prices[-1] < 32_000_00  
  
def should_sell_minmax(prices: list[int]) -> bool:  
    # sell if it's above $33,000  
    return prices[-1] > 33_000_00  
  
@dataclass  
class TradingBot:  
    """Trading bot that connects to a crypto exchange and performs trades."""  
  
    exchange: Exchange  
    buy_strategy: TradingStrategyFunction  
    sell_strategy: TradingStrategyFunction  
  
    def run(self, symbol: str) -> None:  
        prices = self.exchange.get_market_data(symbol)  
        should_buy = self.buy_strategy(prices)  
        should_sell = self.sell_strategy(prices)  
        if should_buy:  
            self.exchange.buy(symbol, 10)  
        elif should_sell:  
            self.exchange.sell(symbol, 10)  
        else:  
            print(f'No action required for {symbol}.')  
  
def main() -> None:  
    # Creates the exchange and connects to it  
    exchange = Exchange()  
    exchange.connect()  
  
    # create the trading bot and run the bot once  
    bot = TradingBot(exchange, should_buy_avg, should_sell_avg)  
    bot.run('BTC/USD')  
  
if __name__ == '__main__':  
    main()
```

However, since we aren't using classes, passing parameters to things like change the window size for trading, isn't possible. We can fix that though by using closures. We just need to wrap the functions we are passing in closures (or all of them) that take in some parameter, adjust the function to use the parameter, and return the function as a result:

```python
"""
Changing the should_buy_avg and should_sell_minmax functions.
"""
def should_buy_avg_closure(window_size: int) -> TradingStrategyFunction:  
    def should_buy_avg(prices: list[int]) -> bool:  
        list_window = prices[-window_size:]  
        return prices[-1] < statistics.mean(list_window)  
    return should_buy_avg
def should_sell_minmax_closure(max_price: int) -> TradingStrategyFunction:  
    def should_sell_minmax(prices: list[int]) -> bool:  
        # sell if it's above $33,000  
        return prices[-1] > max_price  
    return should_sell_minmax

"""
Changing the call in main.
"""
def main() -> None:  
    # Creates the exchange and connects to it  
    exchange = Exchange()  
    exchange.connect()  
  
    # create the trading bot and run the bot once  
    bot = TradingBot(exchange, should_buy_avg_closure(4), should_sell_minmax_closure(35_000_00))  
    bot.run('BTC/USD')
```

This alleviates our issue, but is not very elegant looking and a bit verbose. To avoid that route, we can use partial functions.

A partial function application fixes a number of arguments in the original function and returns a new function without those arguments. Different from querying. It allows us to bypass the `TradingStrategyFunction()` callable without having a type error, since we want to pass in some parameter.

```python
"""  
Using a video (https://www.youtube.com/watch?v=ph2HjBQuI8Y&list=PLU-P2PlzpIf3EpWfxk-Mu_ZVJVS5Wb-_e&index=35)  
to follow along and learn some neat things functions can do  
"""  
import statistics  
from dataclasses import dataclass  
from typing import Callable, Protocol  
from exchange import Exchange  
from functools import partial  
  
TradingStrategyFunction = Callable[list[int], bool]  
  
  
def should_buy_avg(prices: list[int], window_size: int) -> bool:  
    list_window = prices[-window_size:]  
    return prices[-1] < statistics.mean(list_window)  
  
  
def should_sell_avg(prices: list[int], window_size: int) -> bool:  
    list_window = prices[-window_size:]  
    return prices[-1] > statistics.mean(list_window)  
  
  
def should_buy_minmax(prices: list[int], min_price: int) -> bool:  
    return prices[-1] < min_price  
  
def should_sell_minmax(prices: list[int], max_price: int) -> bool:  
    return prices[-1] > max_price  
  
@dataclass  
class TradingBot:  
    """Trading bot that connects to a crypto exchange and performs trades."""  
  
    exchange: Exchange  
    buy_strategy: TradingStrategyFunction  
    sell_strategy: TradingStrategyFunction  
  
    def run(self, symbol: str) -> None:  
        prices = self.exchange.get_market_data(symbol)  
        should_buy = self.buy_strategy(prices)  
        should_sell = self.sell_strategy(prices)  
        if should_buy:  
            self.exchange.buy(symbol, 10)  
        elif should_sell:  
            self.exchange.sell(symbol, 10)  
        else:  
            print(f'No action required for {symbol}.')  
  
def main() -> None:  
    # Creates the exchange and connects to it  
    exchange = Exchange()  
    exchange.connect()  
  
    # create the trading bot and run the bot once  
    buy_strategy = partial(should_buy_avg, window_size=4)  
    sell_strategy = partial(should_sell_minmax, max_price=35_000_00)  
    bot = TradingBot(exchange, buy_strategy, sell_strategy)  
    bot.run('BTC/USD')  
  
if __name__ == '__main__':  
    main()
```
