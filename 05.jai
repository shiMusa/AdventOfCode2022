#import "Basic";
#import "String";

main :: () {
    part1(check, true);
}

part1 :: (input : string, part2: bool) {

    lines := split(input, "\n");

    // * determine the number of stacks and the largest size for parsing
    n_max    : int = ---;
    n_stacks : int = ---;
    for lines {
        if it.data[1] == #char "1" {
            n_max = it_index;

            line := trim(it, "\r\n");
            numbers := split(line, " ");
            // print("numbers = %\n", numbers);

            for i: 0..numbers.count-1 {
                j := numbers.count-1-i;
                // print("checking \"%\"\n", numbers[j]);
                if numbers[j].count != 0 {
                    n_stacks = parse_int(*numbers[j]);
                    break it;
                }
            }
        }
    }

    // * create stacks and add the boxes
    // print("n_max = %, n_stacks = %\n", n_max, n_stacks);
    stacks := NewArray(n_stacks, [..]u8);

    for <i: n_max-1..0 {
        line := trim(lines[i], "\r\n");
        // print("% : \"%\"\n", i, line);
        for s: 0..n_stacks-1 {
            char := line[4*s+1];
            if char == #char " " continue;

            // print_character(line[4*s+1]);
            // print(" = %\n", line[4*s+1]);

            array_add(*stacks[s], char);
        }
    }
    print("stacks = %\n", stacks);


    // * move boxes
    for lines {
        if !it.count continue;
        if it_index < n_max + 2 continue; // * skip stack diagram

        line := trim(it, "\r\n");
        print("command: \"%\"\n", line);

        words := split(line, " ");
        num  := parse_int(*words[1]);
        from := parse_int(*words[3]);
        to   := parse_int(*words[5]);

        print("% --[%]-> %\n", from, num, to);

        if !part2 {
            for i: 0..num-1 {
                box := pop(*stacks[from-1]);
                array_add(*stacks[to-1], box);
            }
        } else {
            for i: 0..num-1 {
                fs := stacks[from-1];
                box := fs[fs.count - num + i];
                array_add(*stacks[to-1], box);
            }
            stacks[from-1].count -= num;
        }

        print("stacks = %\n", stacks);
    }

    // * retriev last elements
    print("res = ");
    for stacks {
        print_character(peek(it));
    }
    print("\n");
}

test :: #string DONE
    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
DONE

check :: #string DONE
[B]                     [N]     [H]
[V]         [P] [T]     [V]     [P]
[W]     [C] [T] [S]     [H]     [N]
[T]     [J] [Z] [M] [N] [F]     [L]
[Q]     [W] [N] [J] [T] [Q] [R] [B]
[N] [B] [Q] [R] [V] [F] [D] [F] [M]
[H] [W] [S] [J] [P] [W] [L] [P] [S]
[D] [D] [T] [F] [G] [B] [B] [H] [Z]
 1   2   3   4   5   6   7   8   9 

move 2 from 8 to 1
move 4 from 9 to 8
move 2 from 1 to 6
move 7 from 4 to 2
move 10 from 2 to 7
move 2 from 1 to 6
move 1 from 9 to 4
move 1 from 4 to 1
move 8 from 6 to 4
move 7 from 1 to 8
move 6 from 8 to 1
move 1 from 4 to 1
move 8 from 7 to 3
move 2 from 5 to 2
move 5 from 3 to 2
move 5 from 2 to 1
move 1 from 6 to 5
move 2 from 2 to 6
move 5 from 8 to 7
move 12 from 7 to 4
move 3 from 5 to 4
move 2 from 6 to 4
move 9 from 1 to 7
move 4 from 3 to 7
move 4 from 3 to 4
move 3 from 1 to 7
move 1 from 9 to 1
move 1 from 1 to 4
move 2 from 5 to 2
move 1 from 3 to 7
move 15 from 7 to 2
move 4 from 7 to 9
move 6 from 9 to 2
move 2 from 8 to 3
move 3 from 2 to 8
move 1 from 7 to 6
move 8 from 2 to 5
move 2 from 8 to 4
move 2 from 3 to 8
move 9 from 5 to 9
move 7 from 4 to 2
move 1 from 8 to 6
move 6 from 9 to 2
move 3 from 9 to 7
move 2 from 8 to 4
move 7 from 2 to 6
move 7 from 4 to 1
move 3 from 1 to 8
move 2 from 1 to 8
move 4 from 8 to 2
move 2 from 1 to 5
move 19 from 2 to 7
move 8 from 4 to 7
move 18 from 7 to 1
move 11 from 7 to 4
move 15 from 1 to 7
move 9 from 4 to 3
move 2 from 3 to 1
move 9 from 4 to 5
move 1 from 8 to 1
move 8 from 6 to 5
move 3 from 2 to 5
move 1 from 6 to 7
move 4 from 4 to 3
move 8 from 5 to 1
move 13 from 1 to 6
move 12 from 7 to 1
move 12 from 6 to 3
move 1 from 7 to 6
move 1 from 7 to 5
move 1 from 1 to 9
move 1 from 3 to 1
move 3 from 1 to 9
move 12 from 3 to 8
move 1 from 9 to 3
move 1 from 6 to 8
move 5 from 5 to 1
move 1 from 6 to 2
move 10 from 8 to 9
move 13 from 9 to 2
move 10 from 3 to 4
move 1 from 8 to 9
move 2 from 8 to 7
move 1 from 3 to 1
move 1 from 5 to 6
move 13 from 2 to 5
move 1 from 9 to 2
move 7 from 1 to 4
move 2 from 2 to 5
move 2 from 7 to 8
move 1 from 6 to 8
move 10 from 5 to 8
move 3 from 7 to 2
move 4 from 1 to 4
move 12 from 4 to 2
move 10 from 5 to 3
move 6 from 2 to 1
move 2 from 4 to 8
move 3 from 4 to 8
move 6 from 1 to 7
move 1 from 7 to 5
move 12 from 8 to 2
move 3 from 4 to 9
move 1 from 4 to 3
move 2 from 9 to 6
move 2 from 6 to 8
move 1 from 1 to 3
move 8 from 2 to 6
move 4 from 1 to 8
move 12 from 2 to 3
move 4 from 6 to 8
move 10 from 8 to 3
move 14 from 3 to 8
move 5 from 5 to 8
move 1 from 7 to 8
move 5 from 3 to 5
move 4 from 7 to 2
move 2 from 6 to 1
move 4 from 3 to 7
move 4 from 5 to 1
move 21 from 8 to 6
move 7 from 3 to 2
move 1 from 5 to 1
move 4 from 8 to 9
move 16 from 6 to 1
move 1 from 8 to 4
move 5 from 9 to 2
move 7 from 1 to 7
move 10 from 1 to 3
move 1 from 4 to 2
move 6 from 6 to 5
move 6 from 1 to 4
move 4 from 7 to 9
move 1 from 6 to 5
move 5 from 7 to 6
move 3 from 6 to 8
move 1 from 7 to 6
move 6 from 4 to 8
move 4 from 8 to 3
move 4 from 8 to 4
move 17 from 2 to 1
move 8 from 3 to 4
move 5 from 4 to 3
move 10 from 1 to 5
move 11 from 3 to 5
move 1 from 7 to 9
move 3 from 6 to 4
move 9 from 4 to 9
move 7 from 1 to 3
move 1 from 4 to 8
move 7 from 5 to 4
move 18 from 5 to 1
move 13 from 1 to 6
move 1 from 1 to 5
move 1 from 1 to 6
move 2 from 3 to 1
move 1 from 3 to 1
move 5 from 1 to 6
move 4 from 5 to 8
move 2 from 4 to 9
move 1 from 1 to 9
move 6 from 3 to 8
move 1 from 4 to 5
move 10 from 8 to 7
move 16 from 6 to 7
move 1 from 5 to 4
move 1 from 7 to 2
move 2 from 2 to 6
move 2 from 8 to 5
move 5 from 4 to 9
move 2 from 5 to 9
move 7 from 9 to 8
move 2 from 6 to 9
move 4 from 8 to 9
move 7 from 9 to 7
move 13 from 9 to 5
move 10 from 5 to 1
move 3 from 8 to 4
move 5 from 1 to 3
move 3 from 5 to 6
move 3 from 9 to 7
move 1 from 1 to 7
move 2 from 1 to 3
move 1 from 6 to 1
move 4 from 3 to 8
move 1 from 8 to 9
move 1 from 8 to 7
move 1 from 8 to 4
move 1 from 9 to 7
move 1 from 8 to 5
move 2 from 4 to 3
move 4 from 6 to 3
move 1 from 5 to 1
move 1 from 6 to 4
move 2 from 4 to 5
move 1 from 4 to 6
move 1 from 6 to 4
move 30 from 7 to 3
move 1 from 5 to 1
move 6 from 7 to 3
move 2 from 1 to 7
move 2 from 1 to 2
move 2 from 2 to 1
move 1 from 4 to 9
move 3 from 1 to 2
move 1 from 9 to 5
move 2 from 7 to 1
move 1 from 7 to 3
move 1 from 1 to 9
move 1 from 5 to 8
move 1 from 1 to 2
move 1 from 7 to 3
move 1 from 9 to 4
move 18 from 3 to 4
move 1 from 5 to 9
move 1 from 9 to 6
move 1 from 2 to 7
move 1 from 8 to 7
move 1 from 6 to 3
move 1 from 7 to 2
move 14 from 4 to 6
move 1 from 7 to 6
move 15 from 6 to 4
move 20 from 3 to 1
move 5 from 4 to 9
move 5 from 4 to 2
move 15 from 1 to 7
move 11 from 7 to 9
move 2 from 7 to 6
move 1 from 6 to 4
move 1 from 6 to 3
move 2 from 7 to 8
move 10 from 4 to 3
move 15 from 9 to 3
move 1 from 9 to 7
move 29 from 3 to 6
move 3 from 1 to 6
move 1 from 8 to 4
move 2 from 4 to 3
move 1 from 8 to 9
move 4 from 6 to 1
move 20 from 6 to 2
move 5 from 1 to 9
move 3 from 6 to 2
move 4 from 6 to 3
move 4 from 3 to 1
move 4 from 1 to 4
move 3 from 4 to 8
move 6 from 3 to 4
move 6 from 2 to 6
move 1 from 7 to 1
move 3 from 6 to 8
move 6 from 9 to 3
move 1 from 1 to 4
move 1 from 1 to 7
move 3 from 4 to 5
move 2 from 6 to 4
move 2 from 5 to 6
move 4 from 8 to 7
move 1 from 5 to 6
move 1 from 8 to 4
move 1 from 8 to 4
move 2 from 4 to 9
move 4 from 7 to 8
move 4 from 4 to 3
move 1 from 7 to 9
move 4 from 8 to 6
move 1 from 3 to 4
move 1 from 3 to 5
move 2 from 4 to 7
move 4 from 6 to 3
move 2 from 9 to 1
move 2 from 7 to 4
move 1 from 5 to 1
move 1 from 3 to 4
move 1 from 9 to 3
move 4 from 4 to 5
move 2 from 5 to 3
move 1 from 5 to 7
move 1 from 5 to 8
move 2 from 6 to 4
move 3 from 1 to 3
move 21 from 3 to 5
move 3 from 6 to 1
move 1 from 7 to 1
move 4 from 2 to 6
move 1 from 8 to 2
move 10 from 2 to 4
move 4 from 1 to 2
move 1 from 6 to 5
move 2 from 6 to 9
move 7 from 4 to 9
move 1 from 6 to 5
move 3 from 9 to 4
move 6 from 2 to 8
move 3 from 9 to 1
move 8 from 4 to 3
move 1 from 9 to 4
move 21 from 5 to 7
move 1 from 1 to 3
move 2 from 9 to 6
move 14 from 7 to 1
move 2 from 4 to 1
move 2 from 8 to 7
move 1 from 8 to 2
move 11 from 2 to 9
move 8 from 9 to 6
move 4 from 7 to 1
move 1 from 7 to 4
move 2 from 3 to 5
move 1 from 1 to 6
move 1 from 8 to 2
move 3 from 7 to 5
move 6 from 1 to 7
move 1 from 8 to 7
move 1 from 4 to 5
move 4 from 6 to 5
move 6 from 7 to 6
move 3 from 9 to 1
move 1 from 7 to 3
move 11 from 5 to 1
move 1 from 5 to 2
move 9 from 6 to 4
move 1 from 7 to 3
move 2 from 6 to 1
move 1 from 2 to 1
move 1 from 2 to 6
move 14 from 1 to 5
move 1 from 8 to 4
move 10 from 1 to 5
move 3 from 5 to 1
move 8 from 3 to 8
move 16 from 5 to 7
move 2 from 1 to 9
move 3 from 8 to 1
move 1 from 2 to 4
move 6 from 7 to 4
move 3 from 5 to 8
move 2 from 3 to 6
move 7 from 1 to 7
move 14 from 4 to 3
move 9 from 7 to 8
move 2 from 4 to 1
move 9 from 8 to 4
move 7 from 8 to 2
move 6 from 1 to 8
move 1 from 9 to 7
move 1 from 1 to 6
move 1 from 9 to 6
move 1 from 5 to 9
move 1 from 5 to 3
move 9 from 4 to 9
move 3 from 3 to 6
move 8 from 6 to 3
move 1 from 2 to 9
move 8 from 9 to 8
move 6 from 2 to 9
move 2 from 6 to 1
move 7 from 8 to 6
move 2 from 9 to 6
move 8 from 7 to 8
move 1 from 4 to 5
move 9 from 3 to 5
move 2 from 1 to 4
move 1 from 7 to 4
move 2 from 4 to 3
move 11 from 8 to 1
move 1 from 4 to 7
move 1 from 7 to 8
move 5 from 1 to 3
move 4 from 6 to 4
move 2 from 4 to 8
move 1 from 4 to 8
move 7 from 8 to 9
move 1 from 8 to 9
move 1 from 8 to 5
move 18 from 3 to 2
move 17 from 2 to 7
move 6 from 5 to 4
move 1 from 2 to 5
move 4 from 4 to 6
move 4 from 6 to 9
move 15 from 7 to 9
move 2 from 1 to 6
move 2 from 7 to 9
move 28 from 9 to 2
move 1 from 6 to 7
move 4 from 6 to 9
move 3 from 1 to 7
move 2 from 6 to 3
move 1 from 4 to 7
move 8 from 9 to 5
move 13 from 5 to 3
move 1 from 5 to 7
move 3 from 9 to 4
move 8 from 3 to 7
move 28 from 2 to 5
move 1 from 9 to 8
move 4 from 3 to 4
move 4 from 7 to 5
move 2 from 3 to 9
move 21 from 5 to 4
move 1 from 5 to 7
move 1 from 3 to 5
move 3 from 5 to 7
move 1 from 1 to 3
move 3 from 7 to 3
move 5 from 7 to 6
move 10 from 4 to 8
move 6 from 5 to 4
move 1 from 9 to 3
move 15 from 4 to 5
move 10 from 4 to 7
move 3 from 3 to 7
move 1 from 3 to 4
move 1 from 3 to 4
move 7 from 5 to 1
move 2 from 4 to 7
move 1 from 9 to 2
move 2 from 6 to 9
move 1 from 5 to 3
move 1 from 3 to 8
move 10 from 7 to 9
move 2 from 8 to 1
move 9 from 9 to 2
move 1 from 4 to 3
move 9 from 8 to 7
move 1 from 2 to 8
move 5 from 5 to 4
move 1 from 3 to 2
move 5 from 4 to 3
move 3 from 5 to 9
move 6 from 7 to 3
move 1 from 6 to 5
move 5 from 9 to 7
move 2 from 5 to 6
move 3 from 6 to 7
move 4 from 1 to 4
move 6 from 2 to 7
move 17 from 7 to 5
move 1 from 6 to 1
move 5 from 3 to 6
move 10 from 7 to 2
move 1 from 8 to 4
move 1 from 9 to 8
move 3 from 4 to 1
move 1 from 7 to 4
move 5 from 5 to 9
move 2 from 8 to 7
move 3 from 3 to 7
move 4 from 2 to 3
move 3 from 4 to 6
move 7 from 5 to 8
move 7 from 2 to 8
move 4 from 9 to 8
move 12 from 8 to 3
move 17 from 3 to 2
move 1 from 7 to 9
move 1 from 3 to 9
move 3 from 9 to 1
move 2 from 5 to 1
move 1 from 3 to 5
move 4 from 5 to 8
move 6 from 8 to 1
move 17 from 2 to 3
move 13 from 3 to 2
move 1 from 3 to 9
move 1 from 8 to 4
move 1 from 4 to 8
move 1 from 9 to 1
move 2 from 7 to 2
move 8 from 6 to 2
move 2 from 7 to 5
move 9 from 1 to 3
move 13 from 2 to 9
move 6 from 1 to 4
move 6 from 4 to 5
move 3 from 8 to 1
move 2 from 1 to 8
move 8 from 5 to 7
move 2 from 3 to 1
move 9 from 3 to 1
move 3 from 8 to 2
move 1 from 1 to 9
move 1 from 3 to 9
move 6 from 7 to 3
move 4 from 2 to 7
move 14 from 1 to 6
move 2 from 3 to 9
move 3 from 3 to 7
move 6 from 2 to 1
move 2 from 1 to 2
move 9 from 6 to 3
move 11 from 9 to 5
move 9 from 7 to 6
move 6 from 6 to 2
move 1 from 1 to 8
move 5 from 9 to 4
move 1 from 8 to 5
move 9 from 2 to 7
move 10 from 5 to 8
DONE