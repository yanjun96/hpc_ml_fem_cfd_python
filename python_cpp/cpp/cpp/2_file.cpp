#include <fstream>

int main() {
    std::ofstream myfile;
    myfile.open("example.txt");
    myfile << "Text in file\n, and what fuck";
    myfile.close();
    return 0;
}   