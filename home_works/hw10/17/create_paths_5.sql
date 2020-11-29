CREATE VIEW Create_paths_5 ( level1, level2, level3, level4, level5 ) AS
  SELECT O1.emp AS e1, O2.emp AS e2, O3.emp AS e3, O4.emp AS e4, O5.emp AS e5
  FROM Personnel_org_chart AS O1
  LEFT OUTER JOIN Personnel_org_chart AS O2 ON O1.emp = O2.boss
  LEFT OUTER JOIN Personnel_org_chart AS O3 ON O2.emp = O3.boss 
  LEFT OUTER JOIN Personnel_org_chart AS O4 ON O3.emp = O4.boss
  LEFT OUTER JOIN Personnel_org_chart AS O5 ON O4.emp = O5.boss
  -- Если закомментировать условие WHERE, тогда будут построены
  -- цепочки, начинающиеся с каждого работника, а не только с главного
  -- руководителя.
  WHERE O1.emp = 'Иван';

  SELECT * FROM Create_paths_5;