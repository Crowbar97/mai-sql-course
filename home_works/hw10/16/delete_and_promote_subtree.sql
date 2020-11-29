SELECT * FROM delete_and_promote_subtree(
    ( SELECT emp_nbr FROM Personnel
      WHERE emp_name = 'Ирина' )
);

SELECT * FROM Personnel_org_chart;
SELECT * FROM Create_paths;