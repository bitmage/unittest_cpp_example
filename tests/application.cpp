#include "lib/UnitTest++.h"

#include "../src/application.h"

namespace {

  TEST(ValidCheckSucceeds)
  {
      Application app;
      CHECK(app.greeting() == "Hello world!\n");
  }

}
