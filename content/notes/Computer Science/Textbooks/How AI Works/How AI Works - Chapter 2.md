---
aliases:
draft: false
tags:
  - computerscience
  - AI
  - machine_learning
  - textbook
title: How AI Works - Chapter 2
date: 2025-09-10
updated: 2025-09-30T13:27
---

-------------------------------------------------------------------------------


# Why Now? History of AI

Like we learned in the last chapter, AI has been around for a while. In the grand scheme of things, this "while" is seen as a blip, still in it's infancy. It certainly did not just appear with ChatGPT. Let's take a look at the landscape that got us here.

## Types of AI

I know I said we'd get a lot of definitions out of the way in the last chapter, but I lied. We have some more to go. AI can fall into two major categories; *Symbolic AI* and *Connectionism*. Where symbolic AI takes advantage of visual symbols and logical statements to build it's "intelligence", connectionism will try to build it's intelligence using a compilation of simpler, smaller components. These are significant because it's how our human brains work. We consider symbolic to be "Top-Down" (high level tasks getting broken up) and connectionism as "Bottom-up" (smaller tasks combined to create larger complex tasks).

For today, due to the advancements made with neural networks and deep learning, we can safely assume that connectionism has a slight advantage over symbolic. Most people correctly assume that for complex thought, a strong foundation is integral to growth.

## Pre-1900's

People have been trying to create what we understand today as robots for generations. Some were honest attempts, others were purely for the bit (see the Mechanical Turk). One of the early attempts to understand automation was through Julien Offray de La Mettrie, who published *Man as Machine* in the 1750's. He and many others began to question that it should be possible to recreate the way our brains (biological machines) think.

Moving into the 1800's, George Boole writes the *Laws of Thought* in 1854, attempting to "investigate the fundamental laws of of those operations of the mind..." He unfortunately never accomplished what he set out to achieve, but in the process came out with boolean algebra, an extremely integral part of both algebra and computer science (Boolean expressions are used all the time!). The issues arose when the main component, the actual calculation device, was found to be difficult to create. 

The next fruitful attempt to make this calculation machine was by Charles Babbage and his invention, the Analytical Engine. He never actually got to complete it, but it contained everything that a modern computer has with all of the same capabilities (minus the fancy GUI interface we're all used too). We can thank Ada Lovelace, the world's first programmer, for her push to use and make the Engine readily accessible. Even she knew, however, original thought was not possible with this machine. 

## 1900 to 1950

The 1900's gave us a lot, including the introduction of the Turing Machine in 1936. Alan Turing, only 24 years old at the time, wrote about the concept of a machine that can take in any algorithm and perform any calculation that is computable. Our computers today are just more advanced versions of Turing machines, meaning our computers can take in any valid algorithm and complete anything computable (within the limitations of the computers memory of course).

Turing believed that since computers can perform anything implemented as an algorithm, it should reasonably be able to also perform anything the human brain can do. From this stemmed the *Turing Test*, or a test machines can take and "pass" if they cannot be readily identified as a machine. ChatGPT is one of the most recent models to pass the Turing Test.

## 1950 to 1970

In the year 1956, the **Dartmouth Summer Research Project on Artificial Intelligence workshop** was the real first time the term "Artificial Intelligence" was used consistently. It was basically a giant nerd convention where 50-some mathematicians and computer scientists got together to try and put their minds together to lay down the foundation for the future of AI research. The *Perceptron* was one of the popular machines that took advantage of neural networks, coming from Frank Rosenblatt. While it's configuration would be incredibly similar to the real achievable models of today, his oversell of an all-powerful super computer that can walk, talk, and do everything a human can do, turned a lot of people off (including the US government). It was mostly meant for image recognition, using a 20x20-pixel television for input. 

Another model we're going to get a first hand look at was invented during this period; *Nearest Neighbors* unveiled in 1967 and is incredibly simple in concept. Whenever this model comes across an unknown input, it categorizes it based on the similarities it shares to other features. You'll most often hear about it under it's multi-variable name, *k-nearest neighbors*. Even with all of these advancements, it was understood that the current capabilities were limited, even if these very same models and discoveries would lead to today's success stories.

## 1980 to 1990

This was a special time in AI, mostly because the Lisp programming language was commercially accessible and paired really well with AI work. Today that job falls on Python. Along with *expert systems* or niche software meant to encapsulate "expert" knowledge, AI became commercial.

So what are these expert systems? Well, to really understand a field, you have to talk to professionals. Accumulating these facts swells into what we all a *knowledge base*. A model can use these knowledge bases to quickly learn rules and facts about a specific field. We consider these expert systems to be symbolic AI, due to their lack of connective intelligence. While expert systems are challenging to build and even more so to maintain, they're not the main focus of current AI trends. It was so niche, that it actually caused a drop-off of AI interest for years. 

While the expert systems hype died off, in 1982 John Hopfield reveled the *Hopfield Network*, which used connectionist networks to simulate storing information distributed over the network, which allowed for a greater use over time than before. Then, in 1986, a paper released by some smart gents introduced the concept of *backpropagation*, which is an algorithm that allows the training of neural networks based off of the errors of their outputs. By allowing the tweaking of weights on the neurons, this lead to more powerful and more accurate systems, even if they weren't taken as seriously as they are today.

## 1990 to 2000

While AI is still in the drop-off zone, a neat introduction was about to be made by Corinna Cortes and Vladimir Vapnik; *support vector machines*, or **SVMs**. These SVMs allowed for a high amount of power without as much use of resources as neural networks; where neural networks needed huge datasets and computational power, SVMs used complex math to obfuscate such necessities. Even though the public wasn't seeing much use out of this, the AI field was beginning to grow again. 

Then, worlds really started to collide. In the greatest year of all time, 1997, we see the defeat of the World Grand Champion of Chess, Garry Kasparov, to IBM's very own [Deep Blue](https://www.youtube.com/watch?v=KF6sLCeBj0s). Not only did this get people excited about Chess (which is always a plus), it showed people that these computers that were known to just be good at math could take on literal super geniuses. It of course should be noted that Deep Blue did have the advantage of Grandmasters overseeing the development process, and rigorously testing it, but it was Deep Blue alone who calculated dozens of moves in advance, far more than what was humanly possible.

We also see the emergence in 1998 of the paper *"Gradient-Based Learning Applied to Document Recognition"*. This is actually where that MNIST dataset comes from! However, it got completely overshadowed for years (14 to be exact). We'll come back to why that was a little later.

## 2000 to 2012

One of the classical models we'll look at further in chapter 3 got introduced in 2001; *random forests*, or a forest of decision trees. We also got *autoencoders* around this time. The focus of an autoencoder is for a neural network to run inputs through an intermediary process, encoding them and actually learning more about the inputs. It recreates the the input using the encoded form. It's a little confusing, but will make more sense as we move on.

There are also *denoising autoencoders*, which are similar but discard a random amount of the input before sending it into the middle process. This challenging task of recreating an input from half of the inputs data helps the model learn even more about the input. Get this, you can actually put a few of these together and create a *stacked denoising autoencoder*, which uses the output of the first to lead into the other, and so on. 

## 2012 to 2021

2012 was a big year, with AlexNet, a neural network model, won a challenge to correctly identify the subject of a given image. It won with a 15% margin of error, meaning it was wrong about 15% of the time. Regardless of the error rate it was still relatively powerful, for example not just allowing for the notice of a dog, but the breed of said dog. We consider AlexNet to be a *convolutional neural network*, and post 2012 we saw a huge influx of challenges these models could accomplish. They even began a [site](https://www.arxiv.org/) where you can read and keep up with all of the advancements. 

2014 saw the real foundational concept that lead to ChatGPT and other like systems; *generative adversarial networks*, or GANs. We'll get more into these in chapter 6, but these models actually "created" (HUGE air quotes) their own output, totally different than the training data they were modeled off of. Leading into *Generative AI*, this really blew the lid open. We also saw the popularity of *reinforcement learning*, another sector of machine learning much like supervised and unsupervised, this time with a focus on rewarding progress based off completion.

Going back a year, we saw Google's DeepMind project successfully train a reinforcement learning model to successfully complete Atari 2600 games, without any prior instructions at all. That doesn't sound so impressive given these games are almost 40 years old and rather basic, Google astounded nearly everyone a little later in 2016 with their AlphaGo model beating Go Champion Lee Sedol. Go is a notoriously difficult game to parse, so this was a huge feat. To go even further, Google took it up a notch a year later with AlphaGo Zero, a Go playing model that had zero knowledge of Go, taught itself by playing itself, and eventually beat the original AlphaGo (with an insane score of 100-0!).

To keep riding the Go train, skipping to 2022, models are actually breaking the most modern Go models by playing obscure and random moves, ones that KataGo (the most recent Go model) were never trained on. The models goal in this case is not to win, but to **match and frustrate**. This key difference gives us a clear insight to a lesson from chapter 1; models are good at interpolating, but bad at extrapolating.

Ending this time period with a small fact that again, the inherent hazards that come with AI have been carefully watched from the jump. There have been multiple conferences, popularizing how to use AI for good intentions. We even saw the White House pass the *"Blueprint for an AI Bill of Rights"* in 2023, meant to protect the American public from AI exploitation. As we learned in history class, however, laws lag behind technology, meaning we still have a decent amount of work to do.

## 2021 to Now

COVID wasn't too much of an issue for machine learning researchers, given this field lends itself well to remote work and online conferences. In the last 5 years, we've seen a huge boom of generative models. Most can not only read and analyze text, but even hand-written text, audio content, video content, you name it. Again, these models aren't thinking the way humans do, but in a different "machine" way. We will explore more of this in greater detail in the coming chapters.

Symbolic AI has truly taken a back seat to the rise of connectionist models and technological innovations. We can think of symbolic AI as dinosaurs and connectionism as mammals; both were on the Earth and originated around the same time, but one had a cataclysmic, with only small remnants still around today (birds!). 

## Connectionist Components

It wasn't symbolic AI alone that stunted the growth of connectionism; it was actually three major factors that needed to advance before we saw real growth in the field; speed, algorithms and data issues.

### Speed

We know every computing device has a CPU, or central processing unit. A CPU works a lot like a brain; everything that comes in is sequential, or ran one at a time. We also know that for a long time, computers weren't graphic intensive; computers often were a terminal prompt and that was that. With the growing desire for videogames and applications with a user interface, the need for graphics lead to to the development of GPUs, or Graphics processing units. Whatever a CPU can do, a GPU can do a 10x, 100x, even 1000x scale.

One of the first major benchmarks was ENIAC, with a speed of 0.00289 million instructions per second, or MIPS. That's around 3000 instructions in a second. Let's compare that to NVIDIA, a major player in the GPU market today, and their A100 GPU. That bad boy sports 312,000,000 MIPS, *730 million times faster*. Obviously, we've come a long way in the speed department. This isn't even half the story. Modern neural networks don't just use one, GPU; they often use dozens to hundreds of them.

### Algorithm

We've been glossing over the fact that in order to train these models to do what we want them to do, is no easy feat. The more complex the use case, the more complex the training process. When we hit chapter 4 we're going to go over the process (collect input, multiply each by a weight, sum, add bias value, and pass to activation function for output), we'll go into each step with more clear detail. For now, all you need to know is that all the input gets chopped up into one output value. How this is done and how the output is generated is the key.

We should think of the neural network *architecture* as the make-up of the network, or the anatomy. Anatomy isn't everything though; we have to be concerned with how the training is done, or the physiology. We knew that training was the way to get there by finding the right values for the weights we mentioned just a moment ago, but for a while there was a missing piece of how exactly the training should be carried out and what those numbers should be. It's only through *algorithms* like backpropagation, network initialization, gradient descent, and more to push the bounds of connectionist networks. 

We used to just randomly select small numbers for these weights, and mess around until we found the right number that gave us the desired result we're looking for. Nowadays, we still do use random numbers, but it's largely based on the network architecture/initialization. 

Since each layer of our neural network feeds into one another, with each node's output value dictated by an *activation function*, we needed to come up with a good representation of our output. We used to use sigmoid or hyperbolic tangents, but got replaced by a long name with a simple check; *rectified linear unit* or **ReLU** simply asks if the input is less than 0. If it is, the output is 0, and if it's not, the output is the input. Weird, but since it's such an easy question, the boost is not just to performance, but speed as well.

Here are some algorithms we'll learn about later, but the more exposure the easier it will be to understand;

- **Dropout**: Randomly selects a portion of the nodes' output to zero during the training phase
- **Batch Normalization**: Edits the input values as it moves from stage to stage, keeping the values within a given range

### Data

The final piece of the AI boom, is the surplus of training data. Due to the explosion of the Internet, data has never been more readily accessible. Before the 1990's, categorizing and collecting data was a huge pain. Now, it's trivial to find things like population data, weather info, and more with websites like Kaggle. A good stat from the textbook; according to [Statista](https://www.statista.com/), in 2022 alone over 500 hours of video footage was uploaded to YouTube every minute. That is an insane amount of data.

# Chapter Summary

- **Symbolic**: Rule-based, uses symbols as the base of understanding. Good for applications with clear instructions and goals, falters under new inputs
- **Connectionist**: Based on human brain patters, gets more intelligent as more input is given. Good with complex data sets, but cannot usually explain how it got there
- Symbolic ruled the landscape for many years, but connectionist is the current most popular of the two
- Thanks to advancements in speed, algorithms, and data, we have huge advancements in the connectionist field of deep learning

# Chapter Resources

- [Article on Symbolic vs Connectionism](https://ojs.aaai.org/aimagazine/index.php/aimagazine/article/view/15111/18883)
- [My favorite Machine Learning YouTube creator](https://www.youtube.com/watch?v=aircAruvnKk)


---
Next: 
[Chapter 3]({{< ref "How AI Works - Chapter 3" >}}) 
