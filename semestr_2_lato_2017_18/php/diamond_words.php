#!/usr/bin/env php
<?php

/**
 * Zwraca array zawierający kolejne podsłowa, w kolejności od najkrótszego.
 */
function to_subwords(string $word) : array {
    $word_length = mb_strlen($word);
    /* tylko slowa o nieparzystej dlugosci uformuja ladny diament,
    inne trzeba bedzie uciac przy dwóch literach */
    $current_length = $word_length % 2 == 0 ? 2 : 1;
    $subwords = [];
    while ($current_length <= $word_length) {
        $current_subword = middle_n_letters($word, $current_length);
        array_push($subwords, $current_subword);
        $current_length += 2;
    }
    return $subwords;
}

/**
 * Zwraca n srodkowych liter ze slowa.
 */
function middle_n_letters(string $from_word, int $n) : string {
    $offset = (mb_strlen($from_word) - $n) / 2;
    return mb_substr($from_word, $offset, $n);
}

/**
 * Zwraca "podwojony" array, uzupelniony o elementy z pierwszej polowy w
 * odwrotnej kolejnosci.
 */
function supplement_subwords(array $first_half) : array {
    $second_half = $first_half;
    // pierwszy podwyraz to pelen wyraz, ktory powinien wystapic tylko raz
    array_pop($second_half);
    $second_half = array_reverse($second_half);
    return array_merge($first_half, $second_half);
}

/*
 * Zwraca gotowy do wyswietlenia string z dlugoscia i spacjami.
 */
function to_output_line(string $subword, string $full_word) : string {
    $subword_length = mb_strlen($subword);
    $full_word_length = mb_strlen($full_word);
    $offset = ($full_word_length - $subword_length) / 2;

    // jesli dlugosc danego podslowa nie jest jednocyfrowa, wiersze sie rozjada
    if ($full_word_length > 9) {
        $offset += mb_strlen($full_word_length) - mb_strlen($subword_length);
    }

    $filling_spaces = str_repeat(' ', $offset);
    return $subword_length . ' ' . $filling_spaces . $subword . $filling_spaces;
}

/**
 * Wlasciwa czesc wykonywalna.
 */
$words = array_slice($argv, 1);
$is_not_first = false;

foreach ($words as $word) {
    if ($is_not_first) {
        print "0" . PHP_EOL;
    }

    $subwords = supplement_subwords(to_subwords($word));
    $output_lines = [];

    foreach ($subwords as $subword) {
        $output_line = to_output_line($subword, $word);
        array_push($output_lines, $output_line);
        print $output_line . PHP_EOL;
    }

    $is_not_first = true;
}
