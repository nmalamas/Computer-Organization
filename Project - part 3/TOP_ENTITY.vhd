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
signal instr_connect : std_logic_vector(31 downto 0);
signal Zero_connect : std_logic;
signal RF_WrEn_con : STD_LOGIC;
signal isLoadByte_con : STD_LOGIC;
signal isConditionalBranch_con : STD_LOGIC;
signal PC_Sel_con : STD_LOGIC;
signal PC_LdEn_con : STD_LOGIC;
signal RF_B_sel_con : STD_LOGIC;
signal RF_WrData_sel_con : STD_LOGIC;
signal ALU_BIn_sel_con : STD_LOGIC;
signal MEM_WrEn_con : STD_LOGIC;
signal ALU_func_con : STD_LOGIC_VECTOR (3 downto 0);
signal immed_operation_con : STD_LOGIC_VECTOR (1 downto 0);
signal ctrl_out_con : STD_LOGIC_VECTOR (14 downto 0);

component DATAPATH
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
--			  RF_WrEn : in STD_LOGIC;
--			  isLoadByte : in STD_LOGIC;
--			  isConditionalBranch : in STD_LOGIC;
--           PC_Sel : in  STD_LOGIC;
--           PC_LdEn : in  STD_LOGIC;
--           RF_B_sel : in  STD_LOGIC;
--           RF_WrData_sel : in  STD_LOGIC;
--           ALU_BIn_sel : in  STD_LOGIC;
--           MEM_WrEn : in  STD_LOGIC;
--           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
--			  immed_operation : in  STD_LOGIC_VECTOR (1 downto 0);
			  CTRL_IN  : in STD_LOGIC_VECTOR (14 downto 0);
			  Instr_to_control : out  STD_LOGIC_VECTOR (31 downto 0);
			  Zero : out STD_LOGIC;
			  Cout : out STD_LOGIC;
			  Ovf : out STD_LOGIC);
end component;


component CONTROL_UNIT
    Port ( Instruction : in  STD_LOGIC_VECTOR (31 downto 0);
			  Zero : in STD_LOGIC;
--			  CLK : in STD_LOGIC;
			  RST : in STD_LOGIC;
			  ctrl_out: out STD_LOGIC_VECTOR(14 downto 0)
	);
end component;

begin

	dpath : DATAPATH
	port map(
		  CLK => CLK,
		  RST => RST,
		  CTRL_IN => ctrl_out_con,
--		  immed_operation => ctrl_out_con(1 downto 0),
--		  ALU_func => ctrl_out_con(5 downto 2),
--		  ALU_BIn_sel => ctrl_out_con(6),
--		  RF_WrData_sel => ctrl_out_con(7),
--		  RF_WrEn => ctrl_out_con(8),
--		  RF_B_sel => ctrl_out_con(9),
--		  PC_LdEn => ctrl_out_con(10),
--		  PC_Sel => ctrl_out_con(11),
--		  isLoadByte => ctrl_out_con(12),
--		  isConditionalBranch => ctrl_out_con(13),
--		  MEM_WrEn => ctrl_out_con(14),
		
		  Instr_to_control => instr_connect,
		  Zero => Zero_connect
	);
	
	ctrl_unit : CONTROL_UNIT
	port map(
		  Instruction => instr_connect,
		  RST => RST,
--		  CLK => CLK,
		  Zero => Zero_connect,
		  
		  ctrl_out => ctrl_out_con
	);

end Behavioral;

