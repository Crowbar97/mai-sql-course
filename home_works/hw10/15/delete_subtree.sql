SELECT * FROM delete_subtree(
    ( SELECT emp_nbr FROM Personnel
      WHERE emp_name = 'Анна' )
);

SELECT * FROM Personnel_org_chart;
SELECT * FROM Create_paths;