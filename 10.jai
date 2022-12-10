#import "Basic";
// using Basic :: #import "Basic";
// #poke_name Basic operator==;
#import "String";
#import "File";
#import "Math";

main :: () {
    part_1(check);
}

part_1 :: (input: string) {
    DEBUG :: false;

    x := 1;
    cycle := 1;

    signal_strength := 0;

    next_cycle :: () #expand {
        cycle += 1;
        if cycle >= 20 && (cycle-20)%40 == 0 {
            signal := cycle * x;
            signal_strength += signal;
        }
    }


    screen : [..][40]u8;

    newline :: () #expand {
        line : [40]u8;
        for 0..40-1 line[it] = #char " ";
        array_add(*screen, line);
    }

    render_position := 0;
    newline();

    render :: () #expand {
        if abs(render_position - x) <= 1
            screen[screen.count-1][render_position] = #char "#";

        render_position += 1;
        if render_position == 40 {
            newline();
            render_position = 0;
        }
    }

    for split(input, "\n") {
        line := trim(it, "\r");
        if !line continue;

        #if DEBUG print("%\n", line);

        words := split(line, " ");

        if words[0] == {
            case "noop"; 
                render();
                next_cycle();
            case "addx";
                render();
                next_cycle();
                
                render();
                change := parse_int(*words[1]);
                x += change;
                next_cycle();
        }
    }

    print("total signal strength = %\n", signal_strength);
    for line: screen {
        // print("line = %\n", line);
        for i: 0..40-1 {
            c : u8 = line[i];
            print_character(c);
        }
        print("\n");
    }
}

test :: #string DONE
addx 15
addx -11
addx 6
addx -3
addx 5
addx -1
addx -8
addx 13
addx 4
noop
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx -35
addx 1
addx 24
addx -19
addx 1
addx 16
addx -11
noop
noop
addx 21
addx -15
noop
noop
addx -3
addx 9
addx 1
addx -3
addx 8
addx 1
addx 5
noop
noop
noop
noop
noop
addx -36
noop
addx 1
addx 7
noop
noop
noop
addx 2
addx 6
noop
noop
noop
noop
noop
addx 1
noop
noop
addx 7
addx 1
noop
addx -13
addx 13
addx 7
noop
addx 1
addx -33
noop
noop
noop
addx 2
noop
noop
noop
addx 8
noop
addx -1
addx 2
addx 1
noop
addx 17
addx -9
addx 1
addx 1
addx -3
addx 11
noop
noop
addx 1
noop
addx 1
noop
noop
addx -13
addx -19
addx 1
addx 3
addx 26
addx -30
addx 12
addx -1
addx 3
addx 1
noop
noop
noop
addx -9
addx 18
addx 1
addx 2
noop
noop
addx 9
noop
noop
noop
addx -1
addx 2
addx -37
addx 1
addx 3
noop
addx 15
addx -21
addx 22
addx -6
addx 1
noop
addx 2
addx 1
noop
addx -10
noop
noop
addx 20
addx 1
addx 2
addx 2
addx -6
addx -11
noop
noop
noop
DONE


check :: #string DONE
noop
noop
addx 5
noop
noop
addx 1
addx 3
addx 2
addx 4
addx 3
noop
addx 2
addx 1
noop
noop
addx 4
noop
addx 1
addx 2
addx 5
addx 3
noop
addx -1
addx -37
addx 37
addx -34
addx 7
noop
addx -2
addx 2
noop
noop
noop
addx 5
addx 2
noop
addx 3
addx 15
addx -8
addx -9
addx 21
addx -9
addx 5
addx 2
addx 3
addx -2
addx -38
noop
addx 3
addx 37
addx -33
addx 5
noop
noop
addx 5
noop
noop
addx 5
noop
addx -1
addx 1
addx 5
noop
noop
addx 5
noop
noop
noop
addx 1
addx 2
noop
addx 3
addx -36
noop
noop
noop
addx 6
addx 21
addx -17
addx 18
addx -8
addx -7
addx 2
addx 5
addx -8
addx 13
addx -2
addx 7
noop
addx -2
addx 5
addx 2
addx 1
noop
addx -38
addx 4
addx 3
noop
addx 34
addx -29
addx -2
addx 10
addx -3
addx 2
addx 3
noop
addx -22
addx 2
addx 23
addx 7
noop
noop
addx 3
noop
addx 2
addx -18
addx 19
addx -38
addx 5
addx 2
noop
addx 1
addx 4
addx 1
noop
noop
addx 2
addx 5
addx 2
noop
addx 1
noop
addx 2
addx 8
addx -1
addx -30
addx 31
addx 2
addx 5
addx -35
noop
DONE