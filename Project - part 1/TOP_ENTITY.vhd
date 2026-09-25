----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:07:21 04/25/2024 
-- Design Name: 
-- Module Name:    TOP_ENTITY - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOP_ENTITY is
	Port(
		RST : IN STD_LOGIC;
		CLK : IN STD_LOGIC
	);
end TOP_ENTITY;

architecture Behavioral of TOP_ENTITY is

--SIGNALS
signal write_enable : std_logic;
signal pc_select : std_logic;
signal pc_LdEnable : std_logic;
signal rf_b_select : std_logic;
signal rf_wrdata_select : std_logic;
signal alu_bin_select : std_logic;
signal alu_function : std_logic_vector(3 downto 0);
signal mem_wrenable : std_logic;
signal instr_connect : std_logic_vector(31 downto 0);
signal Zero_connect : std_logic;
signal isLoadByte_conn : std_logic;
signal isConditionalBranch_conn: std_logic;

component DATAPATH
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
			  RF_WrEn : in STD_LOGIC;
			  isLoadByte : in STD_LOGIC;
			  isConditionalBranch : in STD_LOGIC;
           PC_Sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           RF_WrData_sel : in  STD_LOGIC;
           ALU_BIn_sel : in  STD_LOGIC;
           MEM_WrEn : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
			  Instr_to_control : out  STD_LOGIC_VECTOR (31 downto 0);
			  Zero : out STD_LOGIC;
			  Cout : out STD_LOGIC;
			  Ovf : out STD_LOGIC);
end component;


component CONTROL_UNIT
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
			  Zero : in STD_LOGIC;
			  CLK : in STD_LOGIC;
			  RST : in STD_LOGIC;
			  isLoadByte : out STD_LOGIC;
			  isConditionalBranch : out STD_LOGIC;
           ALU_func : out  STD_LOGIC_VECTOR (3 downto 0);
           ALU_BIn_Sel : out  STD_LOGIC;
           RF_WrData_sel : out  STD_LOGIC;
           WrEn : out  STD_LOGIC;
           RF_B_sel : out  STD_LOGIC;
           PC_LdEn : out  STD_LOGIC;
           PC_sel :out  STD_LOGIC;
           MEM_WrEn : out  STD_LOGIC);
end component;

begin

	dpath : DATAPATH
	port map(
		  CLK => CLK,
		  RST => RST,
		  RF_WrEn => write_enable,
		  isLoadByte => isLoadByte_conn,
		  isConditionalBranch => isConditionalBranch_conn,
		  PC_Sel => pc_select,
		  PC_LdEn => pc_LdEnable,
		  RF_B_sel => rf_b_select,
		  RF_WrData_sel => rf_wrdata_select,
		  ALU_BIn_sel => alu_bin_select,
		  MEM_WrEn => mem_wrenable,
		  ALU_func => alu_function,
		  Instr_to_control => instr_connect,
		  Zero => Zero_connect
	);
	
	ctrl_unit : CONTROL_UNIT
	port map(
		  Instr => instr_connect,
		  CLK => CLK,
		  RST => RST,
		  isLoadByte => isLoadByte_conn,
		  isConditionalBranch => isConditionalBranch_conn,
		  ALU_func => alu_function,
		  ALU_BIn_Sel => alu_bin_select,
		  RF_WrData_sel => rf_wrdata_select,
		  WrEn => write_enable,
		  RF_B_sel => rf_b_select,
		  PC_LdEn => pc_LdEnable,
		  PC_sel => pc_select,
		  MEM_WrEn => mem_wrenable,
		  Zero => Zero_connect
	);

end Behavioral;

