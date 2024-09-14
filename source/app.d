import std.stdio;
import std.file;
import std.string;
import core.stdc.errno;
import std.exception;

string parse_string(string s) {
    s = s.strip;
    if (s.length < 2) {
        stderr.writeln("ERROR: Empty string");
        return "";
    }

    if (!s.startsWith("\"") || !s.endsWith("\"") ) {
        stderr.writeln("ERROR: Wrong format");
        return "";
    }

    return strip(s, "\"");
}

string[string] parse_values(string[] lines) {
    string[string] map;

    foreach(line; lines) {
        auto split_line = split(line, ":");

        map[parse_string(split_line[0])] = parse_string(split_line[1]);
    }

    return map;
}

string[] parse_input(string input) {
    if (input.length < 2) {
        stderr.writeln("ERROR: Empty string");
        return [];
    }

    if (!input.startsWith("{") || !input.endsWith("}") ) {
        stderr.writeln("ERROR: Wrong format");
        return [];
    }

    input = input.strip("{}");
    return input.split(",");
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
    auto result = parse_input(input);
    auto values = parse_values(result);
    writeln(result);
    writeln(values);

    return 0;
}
