#include <fstream>
#include <string>
#include <iostream>

int main() {

    std::ifstream myfile;
    myfile.open("example.txt");
    std::string line;
    while (!myfile.eof()) {
        std::getline(myfile, line);
        std::cout << line << std::endl;
        // can use std::cout <<, if there is no collision with other cout function
    }
}   