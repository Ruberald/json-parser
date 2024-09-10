import std.stdio;
import std.file;
import core.stdc.errno;
import std.exception;

int main(string[] args)
{
    writeln("JSON parser!");

    string input;

    if (args.length == 2) {
        auto file_name = args[1];

        // Read file
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
    }

    writeln(input);

    return 0;
}
