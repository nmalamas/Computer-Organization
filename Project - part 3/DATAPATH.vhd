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
			  CTRL_IN  : in STD_LOGIC_VECTOR (14 downto 0);
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
signal rf_a_con : std_logic_vector(31 downto 0);
signal rf_b_con : std_logic_vector(31 downto 0);
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

-- CONTROL REGISTER SIGNALS
signal ctrl_inputs_at_dec: std_logic_vector(8 downto 0);
signal ctrl_outputs_at_dec: std_logic_vector(8 downto 0);
signal ctrl_outputs_at_exec: std_logic_vector(3 downto 0);
signal ctrl_outputs_at_mem: std_logic_vector(1 downto 0);

-- SYNC signals
signal sync_dec_signal_to_exec: std_logic_vector(14 downto 0);
signal sync_exec_signal_to_mem: std_logic_vector(14 downto 0);
signal sync_mem_signal_to_wb: std_logic_vector(14 downto 0);
signal rt_rs_rd: std_logic_vector(14 downto 0);
signal sync_result_signal_to_wb: std_logic_vector(31 downto 0);
signal decode_in: std_logic_vector(31 downto 0);

-- FORWARDING SIGNALS
signal frwrdA_sel: std_logic_vector(1 downto 0);
signal frwrdB_sel: std_logic_vector(1 downto 0);
signal mux_out_to_aluA: std_logic_vector(31 downto 0);
signal mux_out_to_aluB: std_logic_vector(31 downto 0);
signal frwrd_rslt_or_memOut: std_logic_vector(31 downto 0);
signal regBout_to_MEMIn: std_logic_vector(31 downto 0);

--STALL SIGNALS
signal hdu_out_to_sel: std_logic;
signal ctrlFlow_to_ctrl_rgstr_at_dec: std_logic_vector(8 downto 0);
signal IF_to_DEC_reg_WrEn : std_logic;
signal PC_WrEn : std_logic;


--COMPONENTS--
--DECSTAGE component
component DECSTAGE is
    Port ( 
			  --Inputs--
			  Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_Out : in  STD_LOGIC_VECTOR (31 downto 0);
			  immed_operation  : in STD_LOGIC_VECTOR (1 downto 0);
			  writeBackRegister: in  STD_LOGIC_VECTOR (4 downto 0);
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
			  RST  : in  STD_LOGIC;
			  CLK  : in  STD_LOGIC;
           we   : in  STD_LOGIC;
           Data : in  STD_LOGIC_VECTOR (31 downto 0);
			  Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

-- Control register Components
component DEC_EXEC_CONTROL_REGISTER is
    Port ( 
			  RST  : in  STD_LOGIC;
			  CLK  : in  STD_LOGIC;
           we   : in  STD_LOGIC;
           Data : in  STD_LOGIC_VECTOR (8 downto 0);
			  Dout : out  STD_LOGIC_VECTOR (8 downto 0)
		);
end component;

component EXEC_MEM_CONTROL_REGISTER is
    Port ( 
			  RST  : in  STD_LOGIC;
			  CLK  : in  STD_LOGIC;
           we   : in  STD_LOGIC;
           Data : in  STD_LOGIC_VECTOR (3 downto 0);
			  Dout : out  STD_LOGIC_VECTOR (3 downto 0)
		);
end component;

component MEM_WB_CONTROL_REGISTER is
    Port ( 
			  RST  : in  STD_LOGIC;
			  CLK  : in  STD_LOGIC;
           we   : in  STD_LOGIC;
           Data : in  STD_LOGIC_VECTOR (1 downto 0);
			  Dout : out  STD_LOGIC_VECTOR (1 downto 0)
		);
end component;

component rt_rs_rd_address_holding_rgstr is
    Port ( 
			  RST  : in  STD_LOGIC;
			  CLK  : in  STD_LOGIC;
           we   : in  STD_LOGIC;
           Data : in  STD_LOGIC_VECTOR (14 downto 0);
			  Dout : out  STD_LOGIC_VECTOR (14 downto 0)
		);
end component;

component Forward_Unit is
    Port ( 
			  EX_MEM_rd : in  STD_LOGIC_VECTOR (4 downto 0);
           MEM_WB_rd : in  STD_LOGIC_VECTOR (4 downto 0);
           ID_EX_rs : in  STD_LOGIC_VECTOR (4 downto 0);
           ID_EX_rt : in  STD_LOGIC_VECTOR (4 downto 0);
			  RF_WrEn: in STD_LOGIC;
           ForwardA : out  STD_LOGIC_VECTOR (1 downto 0);
           ForwardB : out  STD_LOGIC_VECTOR (1 downto 0));
end component;

component MUX_3to1 is
    Port ( IN_A : in  STD_LOGIC_VECTOR (31 downto 0);
           IN_B : in  STD_LOGIC_VECTOR (31 downto 0);
           IN_C : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC_VECTOR (1 downto 0);
           MUX_OUT : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component HAZARD_DETECTION_UNIT is
    Port ( 
			  frwrdA: in  STD_LOGIC_VECTOR (1 downto 0);
			  frwrdB: in  STD_LOGIC_VECTOR (1 downto 0);
			  is_previous_instr_load: in STD_LOGIC;
			  IF_DEC_rs : in  STD_LOGIC_VECTOR (4 downto 0);
           IF_DEC_rt : in  STD_LOGIC_VECTOR (4 downto 0);
           ID_EX_rd : in  STD_LOGIC_VECTOR (4 downto 0);
           MEM_WrEn : in  STD_LOGIC;
			  pc_wren : out  STD_LOGIC;
			  if_dec_wren : out  STD_LOGIC;
           stall : out  STD_LOGIC);
end component;

component MUX_2to1_9bits is
    Port ( sel : in  STD_LOGIC;
           IN0 : in  STD_LOGIC_VECTOR (8 downto 0);
           IN1 : in  STD_LOGIC_VECTOR (8 downto 0);
           MUX_OUT : out  STD_LOGIC_VECTOR (8 downto 0));
end component;

--=======================================--

begin

		instruction_fetch : IFSTAGE
		port map(
			  PC_Immed => pc_imm,
           PC_Sel => CTRL_IN(11),
           PC_LdEn => PC_WrEn,
           CLK => CLK,
           RST => RST,
           Instr => instr_connect
		);
		
		IFtoDEC_reg: rgstr 
		PORT MAP(
			RST  => RST,
			CLK  => CLK,
			we   =>  IF_to_DEC_reg_WrEn,
			Data => instr_connect,
			Dout => IF_out_reg
		);
		
	--=======================================--
		
	decode : DECSTAGE
	port map(
			  Instr => IF_out_reg,
           RF_WrEn => ctrl_outputs_at_mem(0),
           ALU_Out => sync_result_signal_to_wb,
           MEM_Out => MEM_out_reg,
			  immed_operation  => CTRL_IN(1 downto 0),
			  writeBackRegister => sync_mem_signal_to_wb(14 downto 10),
           RF_WrData_sel => ctrl_outputs_at_mem(1),
           RF_B_sel => CTRL_IN(9),
			  CLK => CLK,
           RST => RST,
			  
           Immed => imm,
           RF_A => rf_a_con,
           RF_B => rf_b_con
		);
		
		DEC_A_reg: rgstr 
		PORT MAP(
			RST  => RST,
			CLK  => CLK,
			we   =>  '1',
			Data => rf_a_con,
			Dout => DEC_regA
		);
		
		DEC_B_reg: rgstr 
		PORT MAP(
			RST  => RST,
			CLK  => CLK,
			we   =>  '1',
			Data => rf_b_con,
			Dout => DEC_regB
		);
		
		DEC_Immed_reg: rgstr 
		PORT MAP(
			RST  => RST,
			CLK  => CLK,
			we   =>  '1',
			Data => imm,
			Dout => DEC_regImmed
		);
		
		-------------------------------------------------------------------------------
		
		ctrl_rgstr_at_dec: DEC_EXEC_CONTROL_REGISTER 
		PORT MAP(
			RST  => RST,
			CLK  => CLK,
			we   => '1',
			Data => ctrl_inputs_at_dec,
			Dout => ctrl_outputs_at_dec
		);
		
		-------------------------------------------------------------------------------
		
		holding_rgstr_at_dec: rt_rs_rd_address_holding_rgstr 
		PORT MAP(
			RST  => RST,
			CLK  => CLK,
			we   => '1',
			Data => rt_rs_rd,
			Dout => sync_dec_signal_to_exec
		);
		
		-------------------------------------------------------------------------------
		
		hdu: HAZARD_DETECTION_UNIT
		PORT MAP (
			 frwrdA => frwrdA_sel,
			 frwrdB => frwrdB_sel,
			 is_previous_instr_load => ctrl_outputs_at_dec(6),
          IF_DEC_rs => IF_out_reg(25 downto 21),
          IF_DEC_rt => IF_out_reg(15 downto 11),
          ID_EX_rd => sync_dec_signal_to_exec(14 downto 10),
          MEM_WrEn => ctrl_outputs_at_dec(7),
			 
			 pc_wren => PC_WrEn, --for stalling the PC
			 if_dec_wren => IF_to_DEC_reg_WrEn, --for stalling the IF/DEC reg
          stall => hdu_out_to_sel
        ); 
		  
		 stall_selection_mux:MUX_2to1_9bits
		 PORT MAP (
          sel => hdu_out_to_sel,
          IN0 => ctrl_inputs_at_dec, --regular execution(NO STALL)
          IN1 => "000000000", --nop
          MUX_OUT => ctrlFlow_to_ctrl_rgstr_at_dec
        ); 
		
		--=======================================--
	
		exec : EXECUTE
		Port map( 
			  RF_A => mux_out_to_aluA,
			  RF_B => mux_out_to_aluB,
           Immed => DEC_regImmed,
           ALU_Bin_sel => ctrl_outputs_at_dec(4),
           ALU_func => ctrl_outputs_at_dec(3 downto 0),
			  Zero => zer,
			  Cout => Cout,
			  Ovf => Ovf,
           ALU_out => alu_out_connect
		);
		
		EXEC_out_rgstr: rgstr 
		PORT MAP(
			RST  => RST,
			CLK  => CLK,
			we   =>  '1',
			Data => alu_out_connect,
			Dout => EXEC_out_reg
		);
		
		-------------------------------------------------------------------------------
		
		ctrl_rgstr_at_exec: EXEC_MEM_CONTROL_REGISTER 
		PORT MAP(
			RST  => RST,
			CLK  => CLK,
			we   =>  '1',
			Data => ctrl_outputs_at_dec(8 downto 5),
			Dout => ctrl_outputs_at_exec
		);

		-------------------------------------------------------------------------------
		
		holding_rgstr_at_exec: rt_rs_rd_address_holding_rgstr 
		PORT MAP(
			RST  => RST,
			CLK  => CLK,
			we   => '1',
			Data => sync_dec_signal_to_exec,
			Dout => sync_exec_signal_to_mem
		);
		
		-------------------------------------------------------------------------------
		
		frwrd_unit: Forward_Unit
		PORT MAP(
			 EX_MEM_rd => sync_exec_signal_to_mem(14 downto 10),
          MEM_WB_rd => sync_mem_signal_to_wb(14 downto 10),
          ID_EX_rs => sync_dec_signal_to_exec(9 downto 5),
          ID_EX_rt => sync_dec_signal_to_exec(4 downto 0),
          RF_WrEn => ctrl_outputs_at_dec(5),
			 
          ForwardA => frwrdA_sel,
          ForwardB => frwrdB_sel
		);
		
		-------------------------------------------------------------------------------
		
		mux_A: MUX_3to1
		PORT MAP(
			IN_A => DEC_regA,
			IN_B => frwrd_rslt_or_memOut,
			IN_C => EXEC_out_reg,
			sel => frwrdA_sel,
			MUX_OUT => mux_out_to_aluA
		);
		
		mux_B: MUX_3to1
		PORT MAP(
			IN_A => DEC_regB,
			IN_B => frwrd_rslt_or_memOut,
			IN_C => EXEC_out_reg,
			sel => frwrdB_sel,
			MUX_OUT => mux_out_to_aluB
		);
		
		rslt_or_memOut_MUX: MUX_2to1
		PORT MAP(
			SEL => ctrl_outputs_at_mem(1), 
			IN0 => sync_result_signal_to_wb,
			IN1 => MEM_out_reg,
			MUX_OUT => frwrd_rslt_or_memOut
		);
		
		-------------------------------------------------------------------------------
		
		decB_to_MEMIn_reg:rgstr
		PORT MAP(
			RST  => RST,
			CLK  => CLK,
			we   => '1',
			Data => DEC_regB,
			Dout => regBout_to_MEMIn
		);
		
		--=======================================--

		data_memory : DATA_MEM
		PORT MAP(
			  CLK => CLK,
			  isLoadByte => ctrl_outputs_at_exec(3),
           Mem_WrEn => ctrl_outputs_at_exec(2),
           ALU_MEM_Addr => EXEC_out_reg,
           MEM_DataIn => regBout_to_MEMIn,
           MEM_DataOut => memdout
		);
		
		MEM_out_rgstr: rgstr 
		PORT MAP(
			RST  => RST,
			CLK  => CLK,
			we   => '1',
			Data => memdout,
			Dout => MEM_out_reg
		);
		
		-------------------------------------------------------------------------------
		
		ctrl_rgstr_at_mem: MEM_WB_CONTROL_REGISTER 
		PORT MAP(
			RST  => RST,
			CLK  => CLK,
			we   => '1' ,
			Data => ctrl_outputs_at_exec(1 downto 0),
			Dout => ctrl_outputs_at_mem
		);
		
		-------------------------------------------------------------------------------
		
		holding_rgstr_at_mem: rt_rs_rd_address_holding_rgstr 
		PORT MAP(
			RST  => RST,
			CLK  => CLK,
			we   => '1',
			Data => sync_exec_signal_to_mem,
			Dout => sync_mem_signal_to_wb
		);
		
		rslt_holding_rgstr_at_mem: rgstr 
		PORT MAP(
			RST  => RST,
			CLK  => CLK,
			we   => '1',
			Data => EXEC_out_reg,
			Dout => sync_result_signal_to_wb
		);
		
		--=======================================--
		
		immed_selection_mux : MUX_2to1
		port map(
			SEL  => immed_sel,								
			IN0     => EXEC_out_reg,
			IN1     => DEC_regImmed,
			MUX_OUT => pc_imm
		);

--outputs of datapath
Instr_to_control <=IF_out_reg;
Zero <= zer;
isCB <= CTRL_IN(13);

immed_sel <= isCB AND zer;

rt_rs_rd <= IF_out_reg(20 downto 16) & IF_out_reg(25 downto 21) & IF_out_reg(15 downto 11);
ctrl_inputs_at_dec<= CTRL_IN(12) & CTRL_IN(14) & CTRL_IN(7) & CTRL_IN(8) & CTRL_IN(6) & CTRL_IN(5 DOWNTO 2);
end Behavioral;
