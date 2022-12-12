// #import "Basic";
using Basic :: #import "Basic";
#poke_name Basic operator==;
#import "String";
#import "File";
#import "Math";

main :: () {
    // part_1(check);
    part_2(check); // reverse flow
}

I2 :: struct {
    x: int = 0; 
    y: int = 0;
}
operator + :: inline (a: I2, b: I2) -> I2 {
    return I2.{a.x + b.x, a.y + b.y};
}
operator - :: inline (a: I2, b: I2) -> I2 {
    return I2.{a.x - b.x, a.y - b.y};
}
operator == :: inline (a: I2, b: I2) -> bool {
    return a.x == b.x && a.y == b.y;
}

part_1 :: (input: string) {
    MAX :: #run cast(int)S32_MAX;
    map  : [..][..]int;
    flow : [..][..]int;
    rows : int;
    cols : int;

    start : I2;
    goal  : I2;

    for split(input, "\n") {
        line := trim(it, "\r");
        if !line continue;

        rows += 1;
        cols = line.count;

        row : [..]int;
        for c: 0..cols-1 {
            if line[c] == #char "S" {
                array_add(*row, 0);
                start = I2.{it_index, c};
                continue c;
            }
            if line[c] == #char "E" {
                array_add(*row, #char "z" - #char "a");
                goal = I2.{it_index, c};
                continue c;
            }
            array_add(*row, line[c] - #char "a");
        }

        array_add(*map, row);

        steps : [..]int;
        for i: 0..cols-1 array_add(*steps, MAX);
        array_add(*flow, steps);
    } 
    flow[start.x][start.y] = 0; // start

    print("% x % map", rows, cols);
    // print("map\n");
    // for map print("%\n", it);
    // print("flow\n");
    // for flow print("%\n", it);
    print("path % -> %\n", start, goal);

    arrived := false;
    while !arrived {
        for r: 0..rows-1 for c: 0..cols-1 {
            if flow[r][c] != MAX continue c;

            steps := MAX;
            if r > 0      if flow[r-1][c] < steps && map[r-1][c] >= map[r][c]-1 then steps = flow[r-1][c];
            if c > 0      if flow[r][c-1] < steps && map[r][c-1] >= map[r][c]-1 then steps = flow[r][c-1];
            if r < rows-1 if flow[r+1][c] < steps && map[r+1][c] >= map[r][c]-1 then steps = flow[r+1][c];
            if c < cols-1 if flow[r][c+1] < steps && map[r][c+1] >= map[r][c]-1 then steps = flow[r][c+1];

            if steps != MAX then flow[r][c] = steps+1;
        }
        // print("\n");
        // for flow print("%\n", it);
        if flow[goal.x][goal.y] != MAX then arrived = true;
    }
    print("arrived! after % steps\n", flow[goal.x][goal.y]);
    // for flow print("%\n", it);
    print("path % -> %\n", start, goal);
}

part_2 :: (input: string) {
    MAX :: #run cast(int)S32_MAX;
    map  : [..][..]int;
    flow : [..][..]int;
    rows : int;
    cols : int;

    start_positions : [..]I2;
    goal  : I2;

    for split(input, "\n") {
        line := trim(it, "\r");
        if !line continue;

        rows += 1;
        cols = line.count;

        row : [..]int;
        for c: 0..cols-1 {
            if line[c] == #char "S" || line[c] == #char "a" {
                array_add(*row, 0);
                array_add(*start_positions, I2.{it_index, c});
                continue c;
            }
            if line[c] == #char "E" {
                array_add(*row, #char "z" - #char "a");
                goal = I2.{it_index, c};
                continue c;
            }
            array_add(*row, line[c] - #char "a");
        }

        array_add(*map, row);

        steps : [..]int;
        for i: 0..cols-1 array_add(*steps, MAX);
        array_add(*flow, steps);
    } 
    flow[goal.x][goal.y] = 0; // reverse iteration

    print("% x % map", rows, cols);
    print("path % -> %\n", start_positions, goal);

    change_registered := true;
    while change_registered {
        change_registered = false;
        for r: 0..rows-1 for c: 0..cols-1 {
            if flow[r][c] != MAX continue c;

            steps := MAX;
            if r > 0      if flow[r-1][c] < steps && map[r-1][c] <= map[r][c]+1 then steps = flow[r-1][c];
            if c > 0      if flow[r][c-1] < steps && map[r][c-1] <= map[r][c]+1 then steps = flow[r][c-1];
            if r < rows-1 if flow[r+1][c] < steps && map[r+1][c] <= map[r][c]+1 then steps = flow[r+1][c];
            if c < cols-1 if flow[r][c+1] < steps && map[r][c+1] <= map[r][c]+1 then steps = flow[r][c+1];

            if steps != MAX {
                flow[r][c] = steps+1;
                change_registered = true;
            }
        }
        // if flow[goal.x][goal.y] != MAX then arrived = true;
    }
    min := MAX;
    for start_positions {
        print("steps at % : %\n", it, flow[it.x][it.y]);
        if flow[it.x][it.y] < min then min = flow[it.x][it.y];
    }
    print("minimal steps : %\n", min);
    // print("arrived! after % steps\n", flow[goal.x][goal.y]);
    // for flow print("%\n", it);
    // print("path % -> %\n", start, goal);
}

test :: #string DONE
Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi
DONE

check :: #string DONE
abcccccccccccccccccccccccccccccccccccccaaaaaaacccccccaaaaaaaaaaaccccccccccccccccccccaaacaaaaaaaacccccccccccccccccccccccccccccccccccaaaaa
abccccccccccccccccccaaccaacccccccccccccaaaaaaaccccccccaaaaaaaaaaacccccccaaaaccccccccaaaaaaaaaaaaacccccccccccccccccccccccccccccccccaaaaaa
abccccccccccccccccccaaaaaaccccccccccaaaccaaaaaacccccccaaaaaaaaaaccccccccaaaaccccccaaaaaaaaaaaaaaacccccccccccccccccccaaacccccccccccaaaaaa
abcccccccccccccccccccaaaaacccccccccccaaccaacaaaccccccaaaaaaaaaaaccccccccaaaacccccaaaaaaaaacaaaaaaacccccccccccccccccaaaacccccccccccaaacaa
abccccccccccccccccccaaaaaaccccccccaacaaaaaacccccccccaaaaaaaaaaaaacaaaccccaaccccccaaaaaaaaacaacccccccccccccccccaaaccaaaacccccccccccccccaa
abcccccccccccccccccaaaaaaaacccccccaaaaaaaaccccccaaaaaaaacaaaacaaaaaaacccccccccaaccccaaaaaacaaacccccccccccccccaaaakkkaaccccccccccccccccaa
abcccccccccccccccccaaaaaaaaccccccccaaaaaccccaacccaaaaaaaaaaaacaaaaaaccccccccccaacccaaaaaaaaaaaacccccccccccccccakkkkkklcccccccccccccccccc
abaaacccccccccccaaccccaaccccccccccccaaaaaccaaacccaaaaaaaaaaaaaaaaaaaaccccccaaaaaaaacaacccaaaaaaccccccccccccccckkkkkkkllcccccccaaaccccccc
abaaaacccccccaacaaccccaacccccccccccaaacaaaaaaaccccaaaaaaaaaaaaaaaaaaaacccccaaaaaaaaaaaccccaaaaacccccccccccccckkkksssllllccccccaaaaaacccc
abaaaacccccccaaaaacccccccccccaaaccccaacaaaaaaccccaaaaaacaaaaaaaaaaaaaacccccccaaaaccccccccaaaaacccccccccccccckkkksssssllllcccccaaaaaacccc
abaaacccccccccaaaaaaccccccccaaaaccccccccaaaaaaaacaaaaaaaaaaaaacaaacaaacccccccaaaaacccccccaaaaacccccccccccccjkkkrssssssllllccccccaaaccccc
abccccccccccaaaaaaaaccccccccaaaacccccccaaaaaaaaacaacaaaaaaaaaacaaaccccccccccaaacaaccccccccccccccccccccccccjjkkrrsuuussslllllcccccaaccccc
abccaaacccccaaaaacccccccccccaaaaccccccaaaaaaaaaacccccaaaaaaaaaacaaccccccccccaacccacccccccccccccccccccccjjjjjjrrrsuuuussslllllmcccddacccc
abcccaaaccaccacaaaccccccccccccccccccccaaaaaaaccccccccccaaaaaaaaccccccaacccccccccccaaaaacccccccccccccccjjjjjjrrrruuuuuusssllmmmmmddddcccc
abccaaaaaaaacccaaaccccccccccccccccaaacccccaaaccccccccccccaaacccccccccaacccccccccccaaaaacccccccccccccjjjjjrrrrrruuuxuuussqqqqmmmmmdddcccc
abcaaaaaaaacccaaaaaacaaaaaccccccaaaaaaccccaaacccaaccccccccaaccccccaaaaaaaaccaaacccaaaaaaccccccccccccjjjjrrrrrruuuxxxuuuqqqqqqqmmmdddcccc
abaaaaaaaaaccccaaaaacaaaaaccccccaaaaaaaaccccccaaaaaaccccccccccccccaaaaaaaaccaaacaaaaaaaacccccccccccjjjjrrrtttuuuuxxxyvvvvvqqqqmmmdddcccc
abaaaaaaaaaccaaaaaaacaaaaaaccccccaaaaaaaacccccaaaaaaccccccccccccccccaaaaccaaaaaaaaaaaaaacccccccccaaiijqqqrttttuuuxxyyvvvvvvvqqmmmdddcccc
abcaaaaaaaaccaaaaaaaaaaaaaacccccaaaaaaaacccccccaaaacccccaaaaccccccccaaaaacaaaaaaaaccaaccccccccccaaaiiiqqqttttxxxxxxyyyyyyvvvqqmmmdddcccc
abcccaaaaaaacaaaaaaaaaaaaaacccccaaaaaaaaaaaccccaaaaccccaaaaacccccccaaaaaacaaaaaaacccccccccccccccaaaiiiqqqtttxxxxxxxyyyyyyvvqqqmmmdddcccc
SbcccaacccaccccaaacacccaaacccccccccaaaaaaaaacccaccaccccaaaaaaccccccaaccaacccaaaaaccccccccccccccccaaiiiiqqtttxxxxEzzzyyyyvvvqqqmmmddccccc
abccaaaccccccccaaccccccccccccccccccaaaaaaaaccccccccccccaaaaaaccccccccccccccaaacaaaccaacccccccccccccciiiqqqttttxxxyyyyyvvvvqqqmmmdddccccc
abccccccccccccccccccccccccccccccccaaaaaaaccccccccccccccaaaaaacccccccccccccccaacccccaaaaaaaccccccccccciiiqqqttttxxyyyyyvvvrrrnnneeecccccc
abcaaaaccccccccccccccccccccccccccaaaaaaaaccccccccccccccccaacccccccccccccccccccccccccaaaaacccccccccccciiiqqqqttxxyyyyyyyvvrrnnnneeecccccc
abcaaaaacccccccccccccccccccccccccaaaacaaacccaccaaacccccccccccccccccccccccccaaaccccaaaaaaaccccccccccccciiiqqqttwwyywwyyywwrrnnneeeccccccc
abaaaaaacccaccaccccccccccccccccccaaaaccaacccaaaaaaccccccccccccccccaaaccccaaaaaacccaaaaaaaacccccccccccciiiqqqtswwwwwwwwwwwrrnnneeeccccccc
abaaaaaacccaaaaccccccccaaaacccccccaaacccccccaaaaaacccccccccccccccaaaaaaccaaaaaacccaaaaaaaacaaccccccaaciiiqppsswwwwsswwwwwrrrnneeeccccccc
abcaaaaacccaaaaacccccccaaaacccccccccccccccccaaaaaaaccccccccccccccaaaaaaccaaaaaacccccaaaaaaaaaccccccaaaahhpppssswwsssswwwwrrrnneeeacccccc
abcaaaccccaaaaaacccccccaaaaccccccccccccccccaaaaaaaaccccccccccccccaaaaacccaaaaaccccccaacaaaaaaaaccaaaaaahhpppsssssssssrrrrrrnnneeeacccccc
abccccccccaaaaaaccccccccaacccccccccccccccccaaaaaaaaccccaacccccccccaaaaaccaaaaacccccccccaaaaaaaaccaaaaachhpppssssssoosrrrrrrnnneeeaaacccc
abccccccccccaaccccccccccccccccaaaaaccccccaacccaaacccaaaaacccccccccaacaacccccccccccccccccaaaaaaacccaaaaahhhppppssppooooorroonnffeaaaacccc
abaaccccccccccccccccccccccccccaaaaaccccccaacccaaaccccaaaaacccccccccccccccccccccccccccaacaaaaacccccaacaahhhppppppppoooooooooonfffaaaacccc
abaccccccccccccccccccccccccccaaaaaacccaaaaaaaacccccccaaaaaccccccccccccccccccccccccaaaaaaaaaaaccccccccccchhhpppppppgggoooooooffffaacccccc
abaccccccccccccccccccccccccccaaaaaacccaaaaaaaaccccccaaaaaccccccacccaacccccccccccccaaaaaccccaaccccccccccchhhhhhggggggggfffffffffaaacccccc
abaacccccccccccccccccccccccccaaaaaacccccaaaacccccccccaaaacccaacaacaaacccccccccccccaaaaaaacccccccccccccccchhhhgggggggggffffffffccaacccccc
abcccccccaacccccccccccccccccccaaaccccccaaaaaccccccccaaaaccaaaacaaaaacccccccccccccaaaaaaaaccccccccccccccccchhhggggaaaagffffffcccccccccccc
abcccccccaacccccccccccccaacccccccccccccaaaaaaccaaccccaaaaaaaaacaaaaaacccccccaaaacaaaaaaaacccccccccccaacccccccaaaacaaaacccccccccccccccccc
abccccaaaaaaaacccccccaacaaaccccccccccccaaccaacaaaacccaaaaaaaacaaaaaaaaccccccaaaaccacaaaccaaaccccaaaaaacccccccaacccaaaacccccccccccccaaaaa
abccccaaaaaaaacccccccaaaaaccccccccccccccccccccaaaaccccaaaaaaacaaaaaaaaccccccaaaaccccaaaccaaaaaccaaaaaaaacccccccccccaaaccccccccccccccaaaa
abccccccaaaaccccccccccaaaaaaccccccccccccccccccaaaacccaaaaaaaaaaccaaccccccccccaacccccccccaaaaacccaaaaaaaacccccccccccaaaccccccccccccccaaaa
abcccccaaaaaacccccccaaaaaaaacccccccccccccccccccccccaaaaaaaaaaaaaaaacccccccccccccccccccccaaaaaacccaaaaaaaccccccccccccccccccccccccccaaaaaa
DONE