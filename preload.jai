using Basic :: #import "Basic";
// #poke_name Basic operator==;
#import "String";
#import "File";
#import "Math";
#import "Sort";

trimmed :: (txt: *string, body: Code, flags: For_Flags) #expand {
    i := 0;
    for l: split(<<txt, "\n") {
        line := trim(l, "\r");
        if !line continue;

        `it := line;
        `it_index := i;
        defer i += 1;

        #insert body;
    }
}