# Threads examples with mutex

[![N|Solid](https://cldup.com/dTxpPi9lDf.thumb.png)](https://nodesource.com/products/nsolid)

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)


This repository was created to explain a simple Thread and mutex usage.


## Clone Project

```bash
$ git clone https://github.com/MichaelBittencourt/Threads-Examples.git
$ cd Threads-Examples
```

## Test simple thread creation with pthreads

```bash
$ make
$ ./prog
```

## Test mutex

```bash
$ make mutex
$ ./prog
```

## Running Mutex example without mutex on critical section

```bash
$ make mutex_disable
$ ./prog
```

## Test simple thread creation with CPP Threads

```bash
$ make cpp_thread
$ ./prog
```

## Disable mutex in CPP Threads


```bash
$ make mutex_disable_setup cpp_thread
$ ./prog
```



## Cleaning

```bash
$ make clean
```

## Create debug binary

```bash
$ make debug
```

## Create assembly files

```bash
$ make assembly
```

## References

- [Makefile Tutorial in Portuguese](https://www.embarcados.com.br/introducao-ao-makefile/)
- [Source Examples](http://www.cs.loyola.edu/~jglenn/702/S2005/Examples/dup2.html)
- [Posix threads Tutorial](https://www.geeksforgeeks.org/multithreading-c-2/)
- [Full Posix Threads Tutorial](https://www.cs.cmu.edu/afs/cs/academic/class/15492-f07/www/pthreads.html)
- [Threads C++](https://www.cplusplus.com/reference/thread/thread/)
