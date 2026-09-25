----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    05:17:55 04/25/2024 
-- Design Name: 
-- Module Name:    CONTROL_UNIT - Behavioral 
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

entity CONTROL_UNIT is
    Port ( 
			  -- Inputs --
			  Instruction : in  STD_LOGIC_VECTOR (31 downto 0);
			  Zero : in STD_LOGIC;
			  CLK : in STD_LOGIC;
			  RST : in STD_LOGIC;
			  
			  -- Outputs --
			  RF_WrEn : out STD_LOGIC;
           isLoadByte : out STD_LOGIC;
           isConditionalBranch : out STD_LOGIC;
           PC_Sel : out  STD_LOGIC;
           PC_LdEn : out  STD_LOGIC;
           RF_B_sel : out  STD_LOGIC;
           RF_WrData_sel : out  STD_LOGIC;
           ALU_BIn_sel : out  STD_LOGIC;
           MEM_WrEn : out STD_LOGIC;
           ALU_func : out  STD_LOGIC_VECTOR (3 downto 0);
			  immed_operation  : out STD_LOGIC_VECTOR (1 downto 0)
	  );

end CONTROL_UNIT;

architecture Behavioral of CONTROL_UNIT is

--SIGNALS
signal opcode : std_logic_vector(5 downto 0);
signal func : std_logic_vector(5 downto 0);

TYPE State_type IS (FETCH, R_DECODE, R_EXECUTE, ALU_WB, LI_DECODE, LI_EXECUTE, LI_WB, LUI_DECODE, LUI_EXECUTE, LUI_WB, ADDI_DECODE, ADDI_EXECUTE, ADDI_WB, ANDI_DECODE, ANDI_EXECUTE, ANDI_WB,ORI_DECODE, ORI_EXECUTE, ORI_WB, B_DECODE, B_EXECUTE, B_WB, BEQ_DECODE, BEQ_EXECUTE, BNE_DECODE, BNE_EXECUTE, LW_DECODE, LW_EXECUTE, LW_MEM, LW_WB, LB_DECODE, LB_EXECUTE, LB_MEM, LB_WB, SW_DECODE, SW_EXECUTE, SW_MEM, SW_WB);
SIGNAL state : State_type;

begin
process(clk,Instruction,rst,Zero)
	begin
		
			if RST = '1' then
				  -- do nothing
				  RF_WrEn <= '0';
				  isLoadByte <= '0';
				  isConditionalBranch <= '0';
				  PC_Sel <= '0';
				  PC_LdEn <= '0';
				  RF_B_sel <= '0';
				  RF_WrData_sel <= '0';
				  ALU_BIn_sel <= '0';
				  MEM_WrEn <= '0';
				  ALU_func <= "0000";
				  immed_operation <= "00";
				  
				  state <=FETCH;
			else
			func<= Instruction(5 downto 0);
			opcode<= Instruction(31 downto 26);
				if rising_edge(clk)  then
					case state is
					
						when FETCH => 
						-- nop
							if opcode = "000000" then
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '1';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= ALU_WB;
							elsif opcode = "100000" then
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= R_DECODE;
								  
							elsif opcode = "111000" then
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "01";
								  
								  state <= LI_DECODE;
								  
							elsif opcode = "111001" then
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "11";
								  
								  state <= LUI_DECODE;
								  
							elsif opcode = "110000" then
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "01";
								  
								  state <= ADDI_DECODE;
								  
							elsif opcode = "110010" then
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= ANDI_DECODE;
								  
							elsif opcode = "110011" then
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= ORI_DECODE;
								  
							elsif opcode = "111111"then
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "10";
								  
								  state <= B_DECODE;
								  
							elsif opcode = "010000"then
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '1';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "10";
								  
								  state <= BEQ_DECODE;
								  
							elsif opcode = "010001"then
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '1';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "10";
								  
								  state <= BNE_DECODE;
								  
							elsif opcode = "001111"then
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "01";
								  
								  state <= LW_DECODE;
								  
							elsif opcode = "011111"then
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '1';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "01";
								  
								  state <= SW_DECODE;
								  
							elsif opcode = "000011"then
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "01";
								  
								  state <= LB_DECODE;
							end if;
							
						---------------------- DECODE STATES ----------------------
								
						when R_DECODE =>
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= func(3 downto 0);
								  immed_operation <= "00";
								  
								  state <= R_EXECUTE;
							
						when LI_DECODE =>
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '1';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= LI_EXECUTE;
							
						when LUI_DECODE =>
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '1';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= LUI_EXECUTE;
								  
						when ADDI_DECODE =>
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '1';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= ADDI_EXECUTE;
							when ANDI_DECODE =>
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '1';
								  MEM_WrEn <= '0';
								  ALU_func <= "0010";
								  immed_operation <= "00";
								  
								  state <= ANDI_EXECUTE;
							
							when ORI_DECODE =>
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '1';
								  MEM_WrEn <= '0';
								  ALU_func <= "0011";
								  immed_operation <= "00";
								  
								  state <= ORI_EXECUTE;
							
							when B_DECODE =>
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '1';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= B_EXECUTE;
							
							when BEQ_DECODE =>
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '1';
								  if Zero = '1' then
										PC_sel <= '1';
								  else
										PC_sel <= '0';
								  end if;
								  PC_LdEn <= '1';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0001";
								  immed_operation <= "00";
								  
								  state <= BEQ_EXECUTE;
						
							when BNE_DECODE =>
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '1';
								  if Zero = '1' then
										PC_sel <= '0';
								  else
										PC_sel <= '1';
								  end if;
								  PC_LdEn <= '1';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0001";
								  immed_operation <= "00";
								  
								  state <= BNE_EXECUTE;
							
							when LW_DECODE =>
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '1';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= LW_EXECUTE;
							
						when SW_DECODE =>
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '1';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '1';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= SW_EXECUTE;
							
						when LB_DECODE =>
								  RF_WrEn <= '0';
								  isLoadByte <= '1';
								  isConditionalBranch <= '0';
								  PC_sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '1';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= LB_EXECUTE;
							
						---------------------- EXECUTE STATES ----------------------
							
						when R_EXECUTE =>
								  RF_WrEn <= '1';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '1';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= ALU_WB;
							
						when LI_EXECUTE =>
								  RF_WrEn <= '1';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '1';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= LI_WB;
							
						when LUI_EXECUTE =>
								  RF_WrEn <= '1';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '1';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= LUI_WB;
								  
						when ADDI_EXECUTE =>
								  RF_WrEn <= '1';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '1';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= ADDI_WB;
								  
						when ANDI_EXECUTE =>
								  RF_WrEn <= '1';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '1';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= ANDI_WB;
						
						when ORI_EXECUTE =>
								  RF_WrEn <= '1';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '1';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= ORI_WB;
							
					when B_EXECUTE =>
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
									isConditionalBranch <= '0';
								  PC_Sel <= '1';
								  PC_LdEn <= '1';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= B_WB;			
								  
						when BEQ_EXECUTE =>
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
									isConditionalBranch <= '0';
									PC_sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= FETCH;
							
					  when BNE_EXECUTE =>
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
									isConditionalBranch <= '0';
									PC_sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= FETCH;
							
						when LW_EXECUTE =>
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
									isConditionalBranch <= '0';
									PC_sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= LW_MEM;
							
						when SW_EXECUTE =>
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
									isConditionalBranch <= '0';
									PC_sel <= '0';
								  PC_LdEn <= '1';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '1';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= SW_MEM;
							
						when LB_EXECUTE =>
								  RF_WrEn <= '0';
								  isLoadByte <= '1';
									isConditionalBranch <= '0';
									PC_sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= LB_MEM;
						
						---------------------- MEM STATES ----------------------
							
						when LW_MEM =>
								  RF_WrEn <= '1';
								  isLoadByte <= '0';
									isConditionalBranch <= '0';
									PC_sel <= '0';
								  PC_LdEn <= '1';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '1';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= LW_WB;
							
						when SW_MEM =>
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
									isConditionalBranch <= '0';
									PC_sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= FETCH;
						
						when LB_MEM =>
								  RF_WrEn <= '1';
								  isLoadByte <= '0';
									isConditionalBranch <= '0';
									PC_sel <= '0';
								  PC_LdEn <= '1';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '1';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= LB_WB;
							
						---------------------- WB STATES ----------------------
							
						when ALU_WB =>
							if opcode = "100000" OR opcode = "000000" then
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= FETCH;
							 end if;
							 
						when LI_WB =>
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= FETCH;
								  
						when LUI_WB =>
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= FETCH;
								  
						when ADDI_WB =>
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= FETCH;
							
						when ANDI_WB =>
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= FETCH;
							
						when ORI_WB =>
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= FETCH;
							
						when B_WB =>
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= FETCH;

						when LW_WB =>
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= FETCH;
						
						when LB_WB =>
								  RF_WrEn <= '0';
								  isLoadByte <= '0';
								  isConditionalBranch <= '0';
								  PC_Sel <= '0';
								  PC_LdEn <= '0';
								  RF_B_sel <= '0';
								  RF_WrData_sel <= '0';
								  ALU_BIn_sel <= '0';
								  MEM_WrEn <= '0';
								  ALU_func <= "0000";
								  immed_operation <= "00";
								  
								  state <= FETCH;

						when others => 
							null;
					end case;
				end if;
		end if;
	end process;
end Behavioral;