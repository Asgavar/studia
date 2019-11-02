TRIALS = 10_000

function was_winner = teleturniej(guess, will_change)
  options = [1 2 3];
  winning_doors = randi(3);

  goats = options(options != winning_doors & options != guess);
  goat_to_be_shown = goats(randi(length(goats)));

  if will_change
    doors_left = options(options != guess & options != goat_to_be_shown);
    was_winner = (doors_left == winning_doors);
  elseif
    was_winner = (guess == winning_doors);
  end

endfunction

unchanged_1 = 0;
unchanged_2 = 0;
unchanged_3 = 0;

changing_1 = 0;
changing_2 = 0;
changing_3 = 0;

for trial = 1:TRIALS
  unchanged_1 += teleturniej(1, false);
  unchanged_2 += teleturniej(2, false);
  unchanged_3 += teleturniej(3, false);

  changing_1 += teleturniej(1, true);
  changing_2 += teleturniej(2, true);
  changing_3 += teleturniej(3, true);
end

printf("Guessing 1 and staying at it: %d\n", unchanged_1 / TRIALS);
printf("Guessing 2 and staying at it: %d\n", unchanged_2 / TRIALS);
printf("Guessing 3 and staying at it: %d\n", unchanged_3 / TRIALS);
printf("Guessing 1 and changing to the third doors: %d\n", changing_1 / TRIALS);
printf("Guessing 2 and changing to the third doors: %d\n", changing_2 / TRIALS);
printf("Guessing 3 and changing to the third doors: %d\n", changing_3 / TRIALS);
