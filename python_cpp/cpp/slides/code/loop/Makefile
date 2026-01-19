# Compiler
CXX = g++

# Compiler flags
CXXFLAGS = -O2 -Wall -std=c++11

# Executable name
TARGET = convection

# Source files
SRCS = convection.cpp

# Object files
OBJS = $(SRCS:.cpp=.o)

# Default rule: build the executable
all: $(TARGET)

# Rule to link the object files into the final executable
$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(OBJS)

# Rule to compile source files into object files
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Clean up the build
clean:
	rm -f $(OBJS) $(TARGET)

# Phony targets to avoid conflicts with files named 'clean' or 'all'
.PHONY: all clean
