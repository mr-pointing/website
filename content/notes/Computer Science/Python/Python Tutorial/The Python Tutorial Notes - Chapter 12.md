---
aliases:
  - python
draft: false
tags:
  - computerscience
  - python
  - documentation
  - virtualenv
  - packages
title: The Python Tutorial Notes - Chapter 12
date: 2024-07-13
---
Modified: July 19 2024 

-------------------------------------------------------------------------------

## **Virtual Environments and Packages**

### **12.1 Introduction**

Often, you're going to need tools and modules that aren't included with Python by default, or in your standard library. One Python install might not suffice for most applications.

To circumnavigate this, we create *virtual environments*, that act as self-contained directories with an installation of Python, and any number of packages.

### **12.2 Creating Virtual Environments**

We can use the `venv` module to create and manage our own virtual environment.

```sh
python -m venv tutorial-env
```

If it doesn't already exist, this will create a `tutorial-env` virtual environment.

A common directory location for virtual environments is usually `.venv`, keeping the directory hidden in your shell and out of the way while giving it a name that explains why the directory exists. It also prevents clashing with `.env` variables definitions.

You can activate the environment with the following calls:

Windows:

```sh
tutorial-env\Scripts\activate
```

Unix:

```sh
source tutorial-env/bin/activate
```

Once in, you should see in parenthesis your virtual environment, confirming your presence. Once done, you can simply type `deactivate` to exit the environment.

### **12.3 Managing Packages with `pip`**

`pip` is a tool to help install, upgrade, and remove packages in Python. `pip` grabs modules/packages from the [Python Package Index](https://pypi.org/).   

From within your virtual environment, you can use `pip` like so:

```sh
(tutorial-env) $ python -m pip install novas
Collecting novas
  Downloading novas-3.1.1.3.tar.gz (136kB)
Installing collected packages: novas
  Running setup.py install for novas
Successfully installed novas-3.1.1.3
```

`pip show` will return information about a particular package. `pip list` will display all of the packages installed in your virtual environment.
