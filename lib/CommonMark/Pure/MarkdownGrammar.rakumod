use v6;

#use Grammar::Tracer;

grammar CommonMark::Pure::MarkdownGrammar is export {
    token TOP { <block>+ }
    token block { <container> || <block-type> }
    token container { <blockquote> }
    token blockquote { <start-indent> ">" " "? <block-type> }
    token block-type { <atx-heading> || <setx-heading> || <indented-code> || <hrule> || <para> || <blank> }
    token start-indent { " "**0..3 }
    token blank { <start-indent> \n }
    token para { <start-indent> $<text>=(<-[ \n ]>+) \n }
    token atx-heading { <start-indent> ("#"**1..6) ((" "|\t)* $<text>=(<-[ \n ]>*))? \n }
    token setx-heading { <start-indent> $<type>=("=" | "-")+ (" "|\t)* \n }
    token hrule { <start-indent> ( <hrule-star> | <hrule-dash> | <hrule-under> ) " "* \n }
    token hrule-star  { "*" (" "|\t)* "*" (" "|\t)* "*" (\t|" "|"*")* }
    token hrule-dash  { "-" (" "|\t)* "-" (" "|\t)* "-" (\t|" "|"-")* }
    token hrule-under { "_" (" "|\t)* "_" (" "|\t)* "_" (\t|" "|"_")* }
    token indented-code { ("    "|\t) $<text>=(<-[ \n ]>+) \n }
}