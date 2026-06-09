library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
    port (
        A       : in  std_logic_vector(7 downto 0);  -- Operando A
        B       : in  std_logic_vector(7 downto 0);  -- Operando B
        ALU_Sel : in  std_logic_vector(2 downto 0);  -- Selector de operación
        Result  : out std_logic_vector(7 downto 0);  -- Resultado
        NZVC    : out std_logic_vector(3 downto 0)   -- Flags: N, Z, V, C
    );
end entity ALU;

architecture behavioral of ALU is
begin

    ALU_PROCESS : process (A, B, ALU_Sel)

        variable Sum_uns : unsigned(8 downto 0);  -- 9 bits para capturar carry

    begin

        -- Valores por defecto (evita latches)
        Result  <= (others => '0');
        NZVC    <= (others => '0');
        Sum_uns := (others => '0');

        -- =============================================
        --  SUMA: ALU_Sel = "000"
        --  Operacion: A + B
        -- =============================================
        if (ALU_Sel = "000") then

            --- Calculo de la suma ---
            Sum_uns := unsigned('0' & A) + unsigned('0' & B);
            Result  <= std_logic_vector(Sum_uns(7 downto 0));

            --- Flag N (Negativo) ---
            -- El bit 7 es el bit de signo
            NZVC(3) <= Sum_uns(7);

            --- Flag Z (Cero) ---
            -- Se activa si el resultado es 00000000
            if (Sum_uns(7 downto 0) = x"00") then
                NZVC(2) <= '1';
            else
                NZVC(2) <= '0';
            end if;

            --- Flag V (Overflow con signo) ---
            -- POS + POS = NEG  → overflow
            -- NEG + NEG = POS  → overflow
            if ((A(7)='0' and B(7)='0' and Sum_uns(7)='1') or
                (A(7)='1' and B(7)='1' and Sum_uns(7)='0')) then
                NZVC(1) <= '1';
            else
                NZVC(1) <= '0';
            end if;

            --- Flag C (Carry / Acarreo sin signo) ---
            -- El bit 8 indica si hubo acarreo
            NZVC(0) <= Sum_uns(8);

        -- =============================================
        --  RESTA: ALU_Sel = "001"
        --  Operacion: A - B  (equivale a A + (~B) + 1)
        -- =============================================
        elsif (ALU_Sel = "001") then

            --- Calculo de la resta ---
            -- Se usa complemento a 2: ~B + 1
            Sum_uns := unsigned('0' & A) + unsigned('0' & (not B)) + 1;
            Result  <= std_logic_vector(Sum_uns(7 downto 0));

            --- Flag N (Negativo) ---
            NZVC(3) <= Sum_uns(7);

            --- Flag Z (Cero) ---
            -- Se activa si A = B (resultado es cero)
            if (Sum_uns(7 downto 0) = x"00") then
                NZVC(2) <= '1';
            else
                NZVC(2) <= '0';
            end if;

            --- Flag V (Overflow con signo) ---
            -- POS - NEG = NEG  → overflow
            -- NEG - POS = POS  → overflow
            -- Nota: En resta, B se niega, por eso comparamos con NOT B(7)
            if ((A(7)='0' and B(7)='1' and Sum_uns(7)='1') or
                (A(7)='1' and B(7)='0' and Sum_uns(7)='0')) then
                NZVC(1) <= '1';
            else
                NZVC(1) <= '0';
            end if;

            --- Flag C (Borrow / Prestamo sin signo) ---
            -- En resta: C=1 significa que NO hubo borrow (A >= B)
            -- En resta: C=0 significa que SI hubo borrow (A < B)
            NZVC(0) <= Sum_uns(8);

        else
            --- Operacion no definida: salida en cero ---
            Result <= (others => '0');
            NZVC   <= (others => '0');

        end if;

    end process ALU_PROCESS;

end architecture behavioral;