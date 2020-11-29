-- From book
SELECT '{ "sports": "хоккей" }'::jsonb || '{ "trips": 5 }'::jsonb;

-- @>	jsonb	Does the left JSON value contain the right JSON path/value entries at the top level?
SELECT '{"a":1, "b":2}'::jsonb @> '{"b":2}'::jsonb;

-- <@	jsonb	Are the left JSON path/value entries contained at the top level within the right JSON value?
SELECT '{"b":2}'::jsonb <@ '{"a":1, "b":2}'::jsonb;

-- ?	text	Does the string exist as a top-level key within the JSON value?
SELECT '{"a":1, "b":2}'::jsonb ? 'b';

-- ?|	text[]	Do any of these array strings exist as top-level keys?
SELECT '{"a":1, "b":2, "c":3}'::jsonb ?| array['b', 'c'];

-- ?&	text[]	Do all of these array strings exist as top-level keys?
SELECT '["a", "b"]'::jsonb ?& array['a', 'b'];

-- ||	jsonb	Concatenate two jsonb values into a new jsonb value
SELECT '["a", "b"]'::jsonb || '["c", "d"]'::jsonb;

-- -	text	Delete key/value pair or string element from left operand. Key/value pairs are matched based on their key value.
SELECT '{"a": "b"}'::jsonb - 'a';

-- -	integer	Delete the array element with specified index (Negative integers count from the end). Throws an error if top level container is not an array.
SELECT '["a", "b"]'::jsonb - 1;

-- #-	text[]	Delete the field or element with specified path (for JSON arrays, negative integers count from the end)
SELECT '["a", {"b":1}]'::jsonb #- '{1,b}';