SELECT * FROM new_pilots;

SELECT * FROM new_pilots WHERE meal[2][3] = 'чай';

SELECT * FROM new_pilots WHERE meal[1][2] = 'каша';

SELECT * FROM new_pilots WHERE 'энергетик' = ANY (meal);