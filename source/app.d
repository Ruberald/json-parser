import std.stdio;
import std.file;
import std.string;
import core.stdc.errno;
import std.exception;

void parse_input(string input) {
    if (input.length == 0) {
        stderr.writeln("ERROR: Empty string");
        return;
    }

    if (input[0] != '{' || input[input.length - 1] != '}') {
        stderr.writeln("ERROR: Wrong format");
        return;
    }
}

string read_input(string file_name) {
    string input;

    try {
        input = readText(file_name);
    } catch (FileException ex) {
        switch(ex.errno) {
            case EPERM:
            case EACCES:
                stderr.writeln("ERROR: Permission denied.");
                break;

            case ENOENT:
                stderr.writeln("ERROR: File does not exist.");
                break;

            default:
                stderr.writefln("ERROR: Failed with %s.", ex.errno);
                break;

        }
    } catch (Exception ex) {
        stderr.writefln("ERROR: Failed with %s.", ex);
    }

    return input;
}

int main(string[] args)
{
    writeln("JSON parser!");

    string input;

    if (args.length == 2) {
        auto file_name = args[1];

        input = read_input(file_name);
    } else {
        stderr.writeln("ERROR: Provide file name");
    }

    input = input.strip;
    
    parse_input(input);
    writeln(input);

    return 0;
}
