library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_TB is
end entity ALU_TB;

architecture behavioral of ALU_TB is

    component ALU
        port (
            A       : in  std_logic_vector(7 downto 0);
            B       : in  std_logic_vector(7 downto 0);
            ALU_Sel : in  std_logic_vector(2 downto 0);
            Result  : out std_logic_vector(7 downto 0);
            NZVC    : out std_logic_vector(3 downto 0)
        );
    end component;

    signal A       : std_logic_vector(7 downto 0) := (others => '0');
    signal B       : std_logic_vector(7 downto 0) := (others => '0');
    signal ALU_Sel : std_logic_vector(2 downto 0) := (others => '0');
    signal Result  : std_logic_vector(7 downto 0);
    signal NZVC    : std_logic_vector(3 downto 0);

begin

    DUT : ALU
        port map (
            A       => A,
            B       => B,
            ALU_Sel => ALU_Sel,
            Result  => Result,
            NZVC    => NZVC
        );

    STIMULUS : process
    begin

        ALU_Sel <= "000";

        A <= "00001001"; B <= "00000101"; wait for 20 ns;
        A <= "00000000"; B <= "00000000"; wait for 20 ns;
        A <= "00000100"; B <= "11101100"; wait for 20 ns;
        A <= "01111111"; B <= "00000011"; wait for 20 ns;
        A <= "10110000"; B <= "10110000"; wait for 20 ns;
        A <= "10000000"; B <= "10000000"; wait for 20 ns;

        ALU_Sel <= "001";

        A <= "00010100"; B <= "00000110"; wait for 20 ns;
        A <= "00001001"; B <= "00001001"; wait for 20 ns;
        A <= "00000100"; B <= "00001000"; wait for 20 ns;
        A <= "10000000"; B <= "00000001"; wait for 20 ns;
        A <= "01111111"; B <= "11111111"; wait for 20 ns;

        ALU_Sel <= "111";
        A <= "10110011"; B <= "01001101"; wait for 20 ns;

        wait;

    end process STIMULUS;

end architecture behavioral;