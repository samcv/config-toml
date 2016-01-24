use v6;
use lib 'lib';
use Test;
use Config::TOML::Parser::Actions;
use Config::TOML::Parser::Grammar;

plan 1;

subtest
{
    my Str $toml = Q:to/EOF/;
    [ '' . "" . '' ]
    a = 1
    b = 2
    '' = 3
    EOF

    my Config::TOML::Parser::Actions $actions .= new;
    my $match_toml = Config::TOML::Parser::Grammar.parse($toml, :$actions);

    is(
        $match_toml.WHAT,
        Match,
        q:to/EOF/
        ♪ [Grammar.parse($toml, :$actions)] - 1 of 4
        ┏━━━━━━━━━━━━━┓
        ┃             ┃  ∙ Parses unordered TOML tables successfully
        ┃   Success   ┃
        ┃             ┃
        ┗━━━━━━━━━━━━━┛
        EOF
    );
    is(
        $match_toml.made{''}{''}{''}{'a'},
        1,
        q:to/EOF/
        ♪ [Is expected value?] - 2 of 4
        ┏━━━━━━━━━━━━━┓
        ┃             ┃  ∙ $match_toml.made{''}{''}{''}{'a'} == 1
        ┃   Success   ┃
        ┃             ┃
        ┗━━━━━━━━━━━━━┛
        EOF
    );
    is(
        $match_toml.made{''}{''}{''}{'b'},
        2,
        q:to/EOF/
        ♪ [Is expected value?] - 3 of 4
        ┏━━━━━━━━━━━━━┓
        ┃             ┃  ∙ $match_toml.made{''}{''}{''}{'b'} == 2
        ┃   Success   ┃
        ┃             ┃
        ┗━━━━━━━━━━━━━┛
        EOF
    );
    is(
        $match_toml.made{''}{''}{''}{''},
        3,
        q:to/EOF/
        ♪ [Is expected value?] - 4 of 4
        ┏━━━━━━━━━━━━━┓
        ┃             ┃  ∙ $match_toml.made{''}{''}{''}{''} == 3
        ┃   Success   ┃
        ┃             ┃
        ┗━━━━━━━━━━━━━┛
        EOF
    );
}

# vim: ft=perl6
