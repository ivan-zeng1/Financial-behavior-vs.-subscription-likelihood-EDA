-- Create raw table for Bank Marketing dataset
-- This table mirrors the original Kaggle CSV structure
-- Data was imported via MySQL Workbench Table Data Import Wizard

CREATE TABLE IF NOT EXISTS `fintech.data`.bank (
  age INT,
  job VARCHAR(50),
  marital VARCHAR(20),
  education VARCHAR(50),
  `default` VARCHAR(10),
  balance INT,
  housing VARCHAR(10),
  loan VARCHAR(10),
  contact VARCHAR(20),
  day INT,
  month VARCHAR(10),
  duration INT,
  campaign INT,
  pdays INT,
  previous INT,
  poutcome VARCHAR(20),
  deposit VARCHAR(10)
);
