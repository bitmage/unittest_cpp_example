#include "lib/UnitTest++.h"

#include "../src/application.h"

namespace {

  TEST(ValidCheckSucceeds)
  {
      bool const b = true;
      CHECK(b);
  }

}
