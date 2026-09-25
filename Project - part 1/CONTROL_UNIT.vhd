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
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
			  Zero : in STD_LOGIC;
			  CLK : in STD_LOGIC;
			  RST : in STD_LOGIC;
           ALU_func : out STD_LOGIC_VECTOR (3 downto 0);
           ALU_BIn_Sel : out STD_LOGIC;
           RF_WrData_sel : out STD_LOGIC;
           WrEn : out  STD_LOGIC;
           RF_B_sel : out  STD_LOGIC;
           PC_LdEn : out  STD_LOGIC;
           PC_sel :out  STD_LOGIC;
           isLoadByte :out  STD_LOGIC;
           isConditionalBranch :out  STD_LOGIC;
           MEM_WrEn : out  STD_LOGIC);
end CONTROL_UNIT;

architecture Behavioral of CONTROL_UNIT is

--SIGNALS
signal instr_25_21 : std_logic_vector(4 downto 0);
signal instr_15_11 : std_logic_vector(4 downto 0);
signal instr_20_16 : std_logic_vector(4 downto 0);
signal instr_5_0 : std_logic_vector(5 downto 0);
signal instr_31_26 : std_logic_vector(5 downto 0);

begin

instr_25_21 <= Instr(25) & Instr(24) & Instr(23) & Instr(22) & Instr(21);
instr_15_11 <= Instr(15) & Instr(14) & Instr(13) & Instr(12) & Instr(11);
instr_20_16 <= Instr(20) & Instr(19) & Instr(18) & Instr(17) & Instr(16);
instr_5_0 <= Instr(5) & Instr(4) & Instr(3) & Instr(2) & Instr(1) & Instr(0);
instr_31_26 <= Instr(31) & Instr(30) & Instr(29) & Instr(28) & Instr(27) & Instr(26);

process(RST,Zero,CLK,Instr,instr_25_21,instr_15_11,instr_20_16,instr_5_0,instr_31_26)
	begin

		if RST = '1' then
			-- Change of outputs
			ALU_func <= "0000";
			ALU_Bin_sel <= '0';

			-- Regular flow of execution 
			PC_sel <= '0';
			PC_LdEn <= '0';
			
			-- Write the data coming from ALU
			RF_WrData_sel <= '0';
			WrEn <= '0';
			RF_B_sel <= '0';
			
			-- No writing in memory
			MEM_WrEn <= '0';
			
			-- Lb check
			isLoadByte <= '0';
			
			-- Conditional branch check
			isConditionalBranch <= '0';
			
		else
			-- nop --
			if Instr = "00000000000000000000000000000000" then
				-- Change of outputs
				ALU_func <= "0000";
				ALU_Bin_sel <= '0';

				-- Regular flow of execution 
				PC_sel <= '0';
				PC_LdEn <= '1';
				
				-- No writing in RF
				RF_WrData_sel <= '0';
				WrEn <= '0';
				RF_B_sel <= '0';
				
				-- No writing in memory
				MEM_WrEn <= '0';
				
				-- Lb check
				isLoadByte <= '0';
				
				-- Conditional branch check
				isConditionalBranch <= '0';
				
			--R-type Instructions --
			-- add --
			elsif (instr_31_26 = "100000" and instr_5_0 = "110000") then
				-- Change of outputs
				ALU_func <= "0000";
				ALU_Bin_sel <= '0';
				
				-- Regular flow of execution 
				PC_sel <= '0';
				PC_LdEn <= '1';
				
				-- Write the data coming from ALU
				RF_WrData_sel <= '0';
				WrEn <= '1';
				RF_B_sel <= '0';
				
				-- No writing in memory
				MEM_WrEn <= '0';
				
				-- Lb check
				isLoadByte <= '0';
				
				-- Conditional branch check
				isConditionalBranch <= '0';
				
			-- sub --
			elsif (instr_31_26 = "100000" and instr_5_0 = "110001") then
				-- Change of outputs
				ALU_func <= "0001";
				ALU_Bin_sel <= '0';

				-- Regular flow of execution 
				PC_sel <= '0';
				PC_LdEn <= '1';
				
				-- Write the data coming from ALU
				RF_WrData_sel <= '0';
				WrEn <= '1';
				RF_B_sel <= '0';
				
				-- No writing in memory
				MEM_WrEn <= '0';
				
				-- Lb check
				isLoadByte <= '0';
				
				-- Conditional branch check
				isConditionalBranch <= '0';
			
			-- and --
			elsif (instr_31_26 = "100000" and instr_5_0 = "110010") then
				-- Change of outputs
				ALU_func <= "0010";
				ALU_Bin_sel <= '0';

				-- Regular flow of execution 
				PC_sel <= '0';
				PC_LdEn <= '1';
				
				-- Write the data coming from ALU
				RF_WrData_sel <= '0';
				WrEn <= '1';
				RF_B_sel <= '0';
				
				-- No writing in memory
				MEM_WrEn <= '0';
				
				-- Lb check
				isLoadByte <= '0';
				
				-- Conditional branch check
				isConditionalBranch <= '0';
			
			-- not --
			elsif (instr_31_26 = "100000" and instr_5_0 = "110100") then
				-- Change of outputs
				ALU_func <= "0100";
				ALU_Bin_sel <= '0';

				-- Regular flow of execution 
				PC_sel <= '0';
				PC_LdEn <= '1';
				
				-- Write the data coming from ALU
				RF_WrData_sel <= '0';
				WrEn <= '1';
				RF_B_sel <= '0';
				
				-- No writing in memory
				MEM_WrEn <= '0';
				
				-- Lb check
				isLoadByte <= '0';
				
				-- Conditional branch check
				isConditionalBranch <= '0';
				
			-- or --
			elsif (instr_31_26 = "100000" and instr_5_0 = "110011") then
				-- Change of outputs
				ALU_func <= "0011";
				ALU_Bin_sel <= '0';

				-- Regular flow of execution 
				PC_sel <= '0';
				PC_LdEn <= '1';
				
				-- Write the data coming from ALU
				RF_WrData_sel <= '0';
				WrEn <= '1';
				RF_B_sel <= '0';
				
				-- No writing in memory
				MEM_WrEn <= '0';
				
				-- Lb check
				isLoadByte <= '0';
				
				-- Conditional branch check
				isConditionalBranch <= '0';
				
			-- sra --
			elsif (instr_31_26 = "100000" and instr_5_0 = "111000") then
				-- Change of outputs
				ALU_func <= "1000";
				ALU_Bin_sel <= '0';

				-- Regular flow of execution 
				PC_sel <= '0';
				PC_LdEn <= '1';
				
				-- Write the data coming from ALU
				RF_WrData_sel <= '0';
				WrEn <= '1';
				RF_B_sel <= '0';
				
				-- No writing in memory
				MEM_WrEn <= '0';
				
				-- Lb check
				isLoadByte <= '0';
				
				-- Conditional branch check
				isConditionalBranch <= '0';
				
			-- sll --
			elsif (instr_31_26 = "100000" and instr_5_0 = "111001") then
				-- Change of outputs
				ALU_func <= "1001";
				ALU_Bin_sel <= '0';

				-- Regular flow of execution 
				PC_sel <= '0';
				PC_LdEn <= '1';
				
				-- Write the data coming from ALU
				RF_WrData_sel <= '0';
				WrEn <= '1';
				RF_B_sel <= '0';
				
				-- No writing in memory
				MEM_WrEn <= '0';
				
				-- Lb check
				isLoadByte <= '0';
				
				-- Conditional branch check
				isConditionalBranch <= '0';
			
			-- srl --
			elsif (instr_31_26 = "100000" and instr_5_0 = "111010") then
				-- Change of outputs
				ALU_func <= "1010";
				ALU_Bin_sel <= '0';

				-- Regular flow of execution 
				PC_sel <= '0';
				PC_LdEn <= '1';
				
				-- Write the data coming from ALU
				RF_WrData_sel <= '0';
				WrEn <= '1';
				RF_B_sel <= '0';
				
				-- No writing in memory
				MEM_WrEn <= '0';
				
				-- Lb check
				isLoadByte <= '0';
				
				-- Conditional branch check
				isConditionalBranch <= '0';
				
			-- rol --
			elsif (instr_31_26 = "100000" and instr_5_0 = "111100") then
				-- Change of outputs
				ALU_func <= "1100";
				ALU_Bin_sel <= '0';

				-- Regular flow of execution 
				PC_sel <= '0';
				PC_LdEn <= '1';
				
				-- Write the data coming from ALU
				RF_WrData_sel <= '0';
				WrEn <= '1';
				RF_B_sel <= '0';
				
				-- No writing in memory
				MEM_WrEn <= '0';
				
				-- Lb check
				isLoadByte <= '0';
				
				-- Conditional branch check
				isConditionalBranch <= '0';
				
			-- ror --
			elsif (instr_31_26 = "100000" and instr_5_0 = "111101") then
				-- Change of outputs
				ALU_func <= "1101";
				ALU_Bin_sel <= '0';

				-- Regular flow of execution 
				PC_sel <= '0';
				PC_LdEn <= '1';
				
				-- Write the data coming from ALU
				RF_WrData_sel <= '0';
				WrEn <= '1';
				RF_B_sel <= '0';
				
				-- No writing in memory
				MEM_WrEn <= '0';
				
				-- Lb check
				isLoadByte <= '0';
			
			-- I-TYPE INSTRUCTIONS --
			-- li --
			elsif (instr_31_26 = "111000") then
				-- Change of outputs
				ALU_func <= "0000";
				ALU_Bin_sel <= '1';

				-- Regular flow of execution 
				PC_sel <= '0';
				PC_LdEn <= '1';
				
				-- Write the data coming from ALU
				RF_WrData_sel <= '0';
				WrEn <= '1';
				RF_B_sel <= '1';
				
				-- No writing in memory
				MEM_WrEn <= '0';
				
				-- Lb check
				isLoadByte <= '0';
				
				-- Conditional branch check
				isConditionalBranch <= '0';
				
			-- lui --
			elsif (instr_31_26 = "111001") then
				-- Change of outputs
				ALU_func <= "0000";
				ALU_Bin_sel <= '1';

				-- Regular flow of execution 
				PC_sel <= '0';
				PC_LdEn <= '1';
				
				-- Write the data coming from ALU
				RF_WrData_sel <= '0';
				WrEn <= '1';
				RF_B_sel <= '1';
				
				-- No writing in memory
				MEM_WrEn <= '0';
				
				-- Lb check
				isLoadByte <= '0';
				
				-- Conditional branch check
				isConditionalBranch <= '0';
			
			-- addi --
			elsif (instr_31_26 = "110000") then
				-- Change of outputs
				ALU_func <= "0000";
				ALU_Bin_sel <= '1';

				-- Regular flow of execution 
				PC_sel <= '0';
				PC_LdEn <= '1';
				
				-- Write the data coming from ALU
				RF_WrData_sel <= '0';
				WrEn <= '1';
				RF_B_sel <= '1';
				
				-- No writing in memory
				MEM_WrEn <= '0';
				
				-- Lb check
				isLoadByte <= '0';
				
				-- Conditional branch check
				isConditionalBranch <= '0';
				
			-- andi --
			elsif (instr_31_26 = "110010") then
				-- Change of outputs
				ALU_func <= "0010";
				ALU_Bin_sel <= '1';

				-- Regular flow of execution 
				PC_sel <= '0';
				PC_LdEn <= '1';
				
				-- Write the data coming from ALU
				RF_WrData_sel <= '0';
				WrEn <= '1';
				RF_B_sel <= '1';
				
				-- No writing in memory
				MEM_WrEn <= '0';
				
				-- Lb check
				isLoadByte <= '0';
				
				-- Conditional branch check
				isConditionalBranch <= '0';
				
			-- ori --
			elsif (instr_31_26 = "110011") then
				-- Change of outputs
				ALU_func <= "0011";
				ALU_Bin_sel <= '1';

				-- Regular flow of execution 
				PC_sel <= '0';
				PC_LdEn <= '1';
				
				-- Write the data coming from ALU
				RF_WrData_sel <= '0';
				WrEn <= '1';
				RF_B_sel <= '1';
				
				-- No writing in memory
				MEM_WrEn <= '0';
				
				-- Lb check
				isLoadByte <= '0';
				
				-- Conditional branch check
				isConditionalBranch <= '0';
				
			-- B --
			elsif (instr_31_26 = "111111") then
				-- Change of outputs
				ALU_func <= "0000";
				ALU_Bin_sel <= '1';

				-- Unconditional Branch
				PC_sel <= '1';
				PC_LdEn <= '1';
				
				-- No writing in RF
				RF_WrData_sel <= '1';
				WrEn <= '0';
				RF_B_sel <= '0';
				
				-- No writing in memory
				MEM_WrEn <= '0';
				
				-- Lb check
				isLoadByte <= '0';
				
				-- Conditional branch check
				isConditionalBranch <= '0';
				
			-- beq --
			elsif (instr_31_26 = "010000") then
				-- Change of outputs
				ALU_func <= "0001";
				ALU_Bin_sel <= '0';

				-- Conditional branch
				if Zero = '1' then
					PC_sel <= '1';
				else
					PC_sel <= '0';
				end if;
				PC_LdEn <= '1';
				
				-- No writing in RF
				RF_WrData_sel <= '0';
				WrEn <= '0';
				RF_B_sel <= '1';
				
				-- No writing in memory
				MEM_WrEn <= '0';
				
				-- Lb check
				isLoadByte <= '0';
				
				-- Conditional branch check
				isConditionalBranch <= '1';
				
			-- bne --
			elsif (instr_31_26 = "010001") then
				-- Change of outputs
				ALU_func <= "0001";
				ALU_Bin_sel <= '0';

				-- Conditional branch
				if Zero = '1' then
					PC_sel <= '0';
				else
					PC_sel <= '1';
				end if;
				PC_LdEn <= '1';
				
				-- No writing in RF
				RF_WrData_sel <= '0';
				WrEn <= '0';
				RF_B_sel <= '1';
				
				-- No writing in memory
				MEM_WrEn <= '0';
				
				-- Lb check
				isLoadByte <= '0';
				
				-- Conditional branch check
				isConditionalBranch <= '1';
				
			-- Lb --
			elsif (instr_31_26 = "000011") then
				-- Change of outputs
				ALU_func <= "0000";
				ALU_Bin_sel <= '1';

				-- Regular flow of execution 
				PC_sel <= '0';
				PC_LdEn <= '1';
				
				-- Write the data coming from Memory
				RF_WrData_sel <= '1';
				WrEn <= '1';
				RF_B_sel <= '1';
				
				-- No writing in memory
				MEM_WrEn <= '0';
				
				-- Lb check
				isLoadByte <= '1';
				
				-- Conditional branch check
				isConditionalBranch <= '0';
				
			-- lw --
			elsif (instr_31_26 = "001111") then
				-- Change of outputs
				ALU_func <= "0000";
				ALU_Bin_sel <= '1';

				-- Regular flow of execution 
				PC_sel <= '0';
				PC_LdEn <= '1';
				
				-- Write the data coming from Memory
				RF_WrData_sel <= '1';
				WrEn <= '1';
				RF_B_sel <= '1';
				
				-- No writing in memory
				MEM_WrEn <= '0';
				
				-- Lb check
				isLoadByte <= '0';
				
				-- Conditional branch check
				isConditionalBranch <= '0';
				
			-- sw --
			elsif (instr_31_26 = "011111") then
				-- Change of outputs
				ALU_func <= "0000";
				ALU_Bin_sel <= '1';

				-- Regular flow of execution 
				PC_sel <= '0';
				PC_LdEn <= '1';
				
				-- No writing in RF
				RF_WrData_sel <= '0';
				WrEn <= '0';
				RF_B_sel <= '1';
				
				-- No writing in memory
				MEM_WrEn <= '1';
				
				-- Lb check
				isLoadByte <= '0';
				
				-- Conditional branch check
				isConditionalBranch <= '0';
				
			end if;
		end if;
		
	end process;
end Behavioral;
