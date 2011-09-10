CXX = g++
CXXFLAGS ?= -g -Wall -W -Winline -ansi
LDFLAGS ?= 
SED = sed
MV = mv
RM = rm

.SUFFIXES: .o .cpp .pde

test = TestUnitTest++
	
test_src = tests/Main.cpp \
	tests/kiln_program.cpp

test_objects = $(patsubst %.cpp, %.o, $(test_src))
test_dependencies = $(subst .o,.d,$(test_objects))

define make-depend
  $(CXX) $(CXXFLAGS) -M $1 | \
  $(SED) -e 's,\($(notdir $2)\) *:,$(dir $2)\1: ,' > $3.tmp
  $(SED) -e 's/#.*//' \
      -e 's/^[^:]*: *//' \
      -e 's/ *\\$$//' \
      -e '/^$$/ d' \
      -e 's/$$/ :/' $3.tmp >> $3.tmp
  $(MV) $3.tmp $3
endef

all: $(test)

$(test): $(lib) $(test_objects)
	@echo Linking $(test)...
	@$(CXX) $(LDFLAGS) -o $(test) $(test_objects) $(lib)
	@echo Running unit tests...
	@./$(test)

clean:
	-@$(RM) $(test_objects) $(test_dependencies) $(test) $(lib) 2> /dev/null

%.o : %.cpp
	@echo $<
	@$(call make-depend,$<,$@,$(subst .o,.d,$@))
	@$(CXX) $(CXXFLAGS) -c $< -o $(patsubst %.cpp, %.o, $<)


ifneq "$(MAKECMDGOALS)" "clean"
-include $(test_dependencies)
endif
