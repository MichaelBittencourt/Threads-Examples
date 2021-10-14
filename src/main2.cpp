// thread example
#include <iostream>       // std::cout
#include <thread>         // std::thread
#include <mutex>

#ifndef DISABLE_MUTEX
std::mutex mtx;
#endif

void foo()
{
#ifndef DISABLE_MUTEX
    mtx.lock();
#endif
    std::cout << "Running foo" << std::endl;
#ifndef DISABLE_MUTEX
    mtx.unlock();
#endif
}

void bar(int x)
{
#ifndef DISABLE_MUTEX
    mtx.lock();
#endif
    std::cout << "Running bar with X: " << x << std::endl;
#ifndef DISABLE_MUTEX
    mtx.unlock();
#endif
}

int main()
{
  std::cout << "main, foo and bar now execute concurrently...\n";

  std::thread first (foo);     // spawn new thread that calls foo()
  std::thread second (bar,0);  // spawn new thread that calls bar(0)

  // synchronize threads:
  first.join();                // pauses until first finishes
  second.join();               // pauses until second finishes

  std::cout << "foo and bar completed.\n";

  return 0;
}
