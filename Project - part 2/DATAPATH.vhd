----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:23:09 04/23/2024 
-- Design Name: 
-- Module Name:    DATAPATH - Behavioral 
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

entity DATAPATH is
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
			  immed_operation  : in STD_LOGIC_VECTOR (1 downto 0);
			  Instr_to_control : out  STD_LOGIC_VECTOR (31 downto 0);--going to control
			  Zero : out STD_LOGIC;
			  Cout : out STD_LOGIC;
			  Ovf : out STD_LOGIC);
end DATAPATH;

architecture Behavioral of DATAPATH is

--SIGNALS--
--IF to DEC SIGNALS
signal instr_connect : std_logic_vector(31 downto 0);

--DEC to IF SIGNALS
signal rf_a : std_logic_vector(31 downto 0);
signal rf_b : std_logic_vector(31 downto 0);
signal imm : std_logic_vector(31 downto 0);

--MEM to EXEC SIGNALS
signal alu_out_connect : std_logic_vector(31 downto 0);
signal adress_bits_11_0 : std_logic_vector(11 downto 0);

--MEM to DEC SIGNALS
signal memdout : std_logic_vector(31 downto 0);

--EXEC to IF SIGNALS
signal pc_imm : std_logic_vector(31 downto 0);

signal immed_sel : std_logic;
signal tmp : std_logic;
signal isCB : std_logic;
signal zer : std_logic;

--MULTICYCLE SIGNALS
signal IF_out_reg: std_logic_vector(31 downto 0);

signal DEC_regA: std_logic_vector(31 downto 0);
signal DEC_regB: std_logic_vector(31 downto 0);
signal DEC_regImmed: std_logic_vector(31 downto 0);

signal EXEC_out_reg: std_logic_vector(31 downto 0);

signal MEM_out_reg: std_logic_vector(31 downto 0);

--COMPONENTS--
--DECSTAGE component
component DECSTAGE is
    Port ( 
			  --Inputs--
			  Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_Out : in  STD_LOGIC_VECTOR (31 downto 0);
			  immed_operation  : in STD_LOGIC_VECTOR (1 downto 0);
           MEM_Out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
			  RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
			  
			  --Outputs--
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0)
           );
end component;

--EXECUTE component
component EXECUTE is
    Port ( 
			  RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
			  Zero : out STD_LOGIC;
			  Cout : out STD_LOGIC;
			  Ovf : out STD_LOGIC;
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

--DATA_MEM component
component DATA_MEM is
    Port ( CLK : in  STD_LOGIC;
			  isLoadByte : in STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

--IFSTAGE component
component IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_Sel   : in  STD_LOGIC;
           PC_LdEn  : in  STD_LOGIC;
           CLK      : in  STD_LOGIC;
           RST      : in  STD_LOGIC;
           Instr    : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component MUX_2to1 is
    Port ( 
			  SEL     : in  STD_LOGIC;
           IN0 		 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
           IN1  		 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
           MUX_OUT    : out  STD_LOGIC_VECTOR(31 DOWNTO 0));
end component;

component rgstr is
    Port ( 
			  --Inputs--
			  RST  : in  STD_LOGIC;
			  CLK  : in  STD_LOGIC;
           we   : in  STD_LOGIC;
           Data : in  STD_LOGIC_VECTOR (31 downto 0);
           
			  --Outputs--
			  Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;


begin

	instruction_fetch : IFSTAGE
	port map(
			  PC_Immed => pc_imm,
           PC_Sel => PC_Sel,
           PC_LdEn => PC_LdEn,
           CLK => CLK,
           RST => RST,
           Instr => instr_connect
		);
		
		IFtoDEC_reg: rgstr 
		PORT MAP(
			RST  => RST,
			CLK  => CLK,
			we   =>'1' ,
			Data => instr_connect,
			Dout => IF_out_reg
		);
		
	-------------------------------------------------------------------------------
		
	decode : DECSTAGE
	port map(
			  Instr => IF_out_reg,
           RF_WrEn => RF_WrEn,
           ALU_Out => EXEC_out_reg,
           MEM_Out => MEM_out_reg,
			  immed_operation  => immed_operation,
           RF_WrData_sel => RF_WrData_sel,
           RF_B_sel => RF_B_sel,
			  CLK => CLK,
           RST => RST,
           Immed => imm,
           RF_A => rf_a,
           RF_B => rf_b
		);
		
		DEC_A_reg: rgstr 
		PORT MAP(
			RST  => RST,
			CLK  => CLK,
			we   => '1' ,
			Data => rf_a,
			Dout => DEC_regA
		);
		
		DEC_B_reg: rgstr 
		PORT MAP(
			RST  => RST,
			CLK  => CLK,
			we   => '1' ,
			Data => rf_b,
			Dout => DEC_regB
		);
		
		DEC_Immed_reg: rgstr 
		PORT MAP(
			RST  => RST,
			CLK  => CLK,
			we   =>'1' ,
			Data => imm,
			Dout => DEC_regImmed
		);
		
		-------------------------------------------------------------------------------
	
		exec : EXECUTE
		Port map( 
			  RF_A => DEC_regA,
			  RF_B => DEC_regB,
           Immed => DEC_regImmed,
           ALU_Bin_sel => ALU_Bin_sel,
           ALU_func => ALU_func,
			  Zero => zer,
			  Cout => Cout,
			  Ovf => Ovf,
           ALU_out => alu_out_connect
		);
		
		EXEC_out_rgstr: rgstr 
		PORT MAP(
			RST  => RST,
			CLK  => CLK,
			we   => '1' ,
			Data => alu_out_connect,
			Dout => EXEC_out_reg
		);
		
		-------------------------------------------------------------------------------

		data_memory : DATA_MEM
		port map(
			  CLK => CLK,
			  isLoadByte => isLoadByte,
           Mem_WrEn => Mem_WrEn,
           ALU_MEM_Addr => EXEC_out_reg,
           MEM_DataIn => DEC_regB,
           MEM_DataOut => memdout
		);
		
		MEM_out_rgstr: rgstr 
		PORT MAP(
			RST  => RST,
			CLK  => CLK,
			we   =>'1' ,
			Data => memdout,
			Dout => MEM_out_reg
		);
		
		-------------------------------------------------------------------------------
		
		immed_selection_mux : MUX_2to1
		port map(
			SEL  => immed_sel,								
			IN0     => EXEC_out_reg,
			IN1     => DEC_regImmed,
			MUX_OUT => pc_imm
		);

--outputs of datapath
Instr_to_control <= instr_connect;
Zero <= zer;
isCB <= isConditionalBranch;

immed_sel <= isCB AND zer;
end Behavioral;
