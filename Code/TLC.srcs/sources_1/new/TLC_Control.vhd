-- Company:
-- Engineer:
--
-- Create Date: 08.09.2018 11:58:12
-- Design Name:
-- Module Name: TLC_Control
-- Project Name: Smart TLC
-- Target Devices: RTL
-- Tool Versions: 2017.2
-- Description: Controller for multiple TLC_GEN
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------
Library IEEE;
Use IEEE.STD_LOGIC_1164.All;
Use IEEE.STD_LOGIC_ARITH.All;
Use IEEE.STD_LOGIC_UNSIGNED.All;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

Entity TLC_Control Is
	Port (
		CLK, RST : In STD_LOGIC;
		IR0,IR1,IR2,IR3 : In STD_LOGIC_VECTOR(2 downto 0);
	    OP0,OP1,OP2,OP3 : Out STD_LOGIC_VECTOR(2 Downto 0)
	);
End TLC_Control;

Architecture Behavioral Of TLC_Control Is
    
    type TLC_State is (RRRG,RRRY,RRGR,RRYR,RGRR,RYRR,GRRR,YRRR,YYYY);
    
    constant longCount : integer := 60;
    constant shortCount : integer := 30;
    constant yellowCount : integer := 5;
    
    signal changeState : STD_LOGIC := '0';
    signal countState : STD_LOGIC := '0';
    signal finIR0, finIR1, finIR2, finIR3 : STD_LOGIC;
    signal count : integer range 0 to longCount;
    signal StopCount : integer;
    signal NxtState : TLC_State;
    signal PrsntState : TLC_State;
    
begin

setIRStates: Process(IR0,IR1,IR2,IR3)
begin
    finIR0 <= IR0(0) and IR0(1) and IR0(2); 
    finIR1 <= IR1(0) and IR1(1) and IR1(2);
    finIR2 <= IR2(0) and IR2(1) and IR2(2);
    finIR0 <= IR3(0) and IR3(1) and IR3(2);
end Process;

SetCount :Process(NxtState)
begin
    if(PrsntState = RRRY or PrsntState <= RRYR or PrsntState <= RYRR or PrsntState <= YRRR  or PrsntState <= YYYY ) then
        StopCount <= yellowCount;
    elsif(finIR0 = '1' or finIR1 = '1' or finIR2 = '1' or finIR3 = '1') then
        StopCount <= longCount;
    else
        StopCount <= shortCount; 
    end if;
end process;

LowerSeq:Process(PrsntState)
begin
    case PrsntState is
        when RRRG => 
                OP0 <= "100";
                OP1 <= "100";
                OP2 <= "100";
                OP3 <= "001";
                NxtState <= RRRY;
        when RRRY => 
                OP0 <= "100";
                OP1 <= "100";
                OP2 <= "100";
                OP3 <= "010";
                NxtState <= RRGR;
        when RRGR => 
                OP0 <= "100";
                OP1 <= "100";
                OP2 <= "001";
                OP3 <= "100";
                NxtState <= RRYR;
        when RRYR =>
                OP0 <= "100";
                OP1 <= "100";
                OP2 <= "010";
                OP3 <= "100";
                NxtState <= RGRR;
        when RGRR =>
                OP0 <= "100";
                OP1 <= "001";
                OP2 <= "100";
                OP3 <= "100";
                NxtState <= RYRR;
        when RYRR =>
                OP0 <= "100";
                OP1 <= "010";
                OP2 <= "100";
                OP3 <= "100";
                NxtState <= GRRR;
        when GRRR =>
                OP0 <= "001";
                OP1 <= "100";
                OP2 <= "100";
                OP3 <= "100";
                NxtState <= YRRR;
        when YRRR =>
                OP0 <= "010";
                OP1 <= "100";
                OP2 <= "100";
                OP3 <= "100";
                NxtState <= RRRG;
        when YYYY =>
               OP0 <= "010";
               OP1 <= "010";
               OP2 <= "010";
               OP3 <= "010";
               NxtState <= RRRG; 
    end case;      
end Process;

HigherSeq: Process(CLK,RST)
begin 
     if(RST = '1') then
        PrsntState <= YYYY;
     elsif(CLK'event and CLK = '1') then
        count <= count + 1;
        if count = StopCount then
            PrsntState <= NxtState;
            count <= 0;
        end if;
     end if;
end Process;
 
end Behavioral;