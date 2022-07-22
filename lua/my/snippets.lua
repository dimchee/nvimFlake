local ls = require'luasnip'
local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local fmt = require'luasnip.extras.fmt'.fmt


ls.add_snippets('cpp', {
    ls.s(
        'main',
        fmt(
        [[
        #include <iostream>
        
        using namespace std;

        auto main() -> int {{
            cout << "Hello!" << endl;
            {}
        }}
        ]], ls.insert_node(1))
    )
})
-- ls.add_snippets('elm', {
--     ls.s(
--         'main',
--         fmt(
--         [[
--         module Main exposing (main)
--         import Browser
--         import Html exposing (text)
--
--         main : Program () () ()
--         main = Browser.element
--             {{ init  = \_ -> ((), Cmd.none)
--             , view = \_ -> text "test!"
--             , update = \_ -> \_ -> ((), Cmd.none) 
--             , subscriptions = \_ -> Sub.none
--             }}
--         ]])
--     )
-- })
