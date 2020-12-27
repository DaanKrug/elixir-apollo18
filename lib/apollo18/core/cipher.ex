defmodule Apollo18.Cipher do

  @moduledoc """
  Provides cipher mechanism to make your things be like Apollo 18: 
  Officially don't exists, only the owner know that it (if ?) exists.
  
  The truth is out there (Maybe ...).
  """

  alias Krug.StringUtil
  alias Krug.NumberUtil
  alias Krug.EtsUtil
  alias Apollo18.CipherUtil
  
  @factor CipherUtil.get_factor()
  @rand_headers CipherUtil.get_headers()

  
  
  @doc """
  Cipher a text/string object. Each time that a same string
  is ciphered, the cipher will be another cipher.
  However when decipher all then will result in same 
  origin string.
  
  The ```salt``` parameter can be used to make more strong the cipher.
  Increase of processing time is also proportional to this value.
  By default the minimum value is equal to 1.
  
  Only supported chars will be ciphered. All non supported chars
  will be removed from original text/string before of
  cipher process. This could generate some decipher "issues".
  
  Supported chars
  ```elixir
    [
      "A","Ä","Ã","Â","Á","À","Æ","А",
      "B","Б","Ъ","Ь","Ы","C","Ç","D","Ð","Д","В","С",
      "E","Ë","Ẽ","Ê","É","È","Э","Е",
      "F","Ф","G","Г","H","Н",
      "I","Ï","Ĩ","Î","Í","Ì",
      "J","Ж","K","К","L","Л",
      "M","М","N","Ñ","И","Й",
      "O","Ö","Õ","Ô","Ó","Ò","Ѳ","О",
      "P","Р","П","Q","R","S","Ш","Щ","T","Т","Þ","Ц","Ч",
      "U","Ü","Ũ","Û","Ú","Ù",
      "V","X","Х","W",
      "Y","Ÿ","Ỹ","Ŷ","Ý","Ỳ","У",
      "Z","З",
      "ẞ","Ю","Я",
      "a","ä","ã","â","á","à","æ","а",
      "b","б","ъ","ь","ы","c","ç","d","ð","д","в","с",
      "e","ë","ẽ","ê","é","è","ə","œ","ɛ","э","е",
      "f","ф","g","г","h","н",
      "i","ï","ĩ","î","í","ì",
      "j","ж","k","к","l","л",
      "m","м","n","ñ","и","й",
      "o","ö","õ","ô","ó","ò","ѳ","о",
      "p","р","п","q","r","s","ш","щ","t","т","þ","ц","ч",
      "u","ü","ũ","û","ú","ù",
      "v","x","х","w",
      "y","ÿ","ỹ","ŷ","ý","ỳ","у",
      "z","з",
      "ß","ю","я",
      "ʃ","ʒ","ʁ","ɾ",
      "Ѣ","ѣ","Ѵ","ѵ",
      "0","1","2","3","4","5","6","7","8","9",
      " ",".",",",";",":","<",">","/","\\","?","|",
      "[","]","{","}","(",")","º","°","ª",
      "+","-","=","_","*","&","%","$","#","@",
      "~","^","´","`","‘","’","“","”",
      "!","'","\"","\\n","\\r","\\t","\\b","\\f"
    ]
  ```
  
  
  ## Examples
    
  ```elixir
  iex > Apollo18.Cipher.cipher("mytext")
  "789C4111413031FF412031DFD115D167D176D143D137D176"
  ```
  ```elixir
  iex > Apollo18.Cipher.cipher("mytext")
  "FFD8FFEE4129414031DF31DF31FF021402660275024202360275"
  ```
  ```elixir
  iex > Apollo18.Cipher.cipher("mytext")
  "1F8B411131EF4110415031CFA0EAA03DA04CA019A00DA04C"
  ```
  ```elixir
  iex > Apollo18.Cipher.cipher("mytext",2)
  "CAFEBABE41594120410041004100918F9193918F918491CF91DF91B
  F91B391BF9193917F915F919F916F916F916F919F916F919F915F919
  F916F915F915F918F916F91939184919F916F91AF915F916F917F91E
  F91BF916F917F910491DF916F917F918491CF916F917F9193919F916
  F917F914391DF916F917F918491CF"
  ```
  ```elixir
  iex > Apollo18.Cipher.cipher("mytext",3)
  "504B0506313F4130413031DF4150E143E172E134E1B3E1F2E172E1F2
  E1B3E14FE11FE10FE11FE14FE11FE14FE10FE13FE11FE163E134E14FE
  11FE10FE10FE14FE11FE11FE10FE10FE12FE11FE172E10FE12FE11FE1
  72E10FE12FE1B3E19FE134E11FE163E1B3E10FE12FE1B3E19FE10FE12
  FE10FE172E10FE12FE1B3E19FE10FE12FE10FE172E10FE12FE163E19F
  E10FE12FE1F2E19FE134E11FE1B3E163E134E11FE163E1B3E10FE12FE
  1B3E19FE10FE12FE1F2E19FE10FE12FE172E19FE10FE12FE172E19FE1
  0FE12FE163E19FE10FE12FE1F2E19FE134E11FE163E1B3E134E11FE16
  3E1B3E10FE12FE163E19FE10FE12FE1F2E19FE134E11FE10FE1B3E134
  E11FE163E1B3E10FE12FE143E19FE10FE12FE172E19FE134E11FE163E
  1B3E10FE12FE163E19FE10FE12FE143E19FE10FE12FE172E19FE10FE1
  2FE1B3E19FE10FE12FE10FE172E10FE12FE143E19FE10FE12FE172E19
  FE10FE12FE134E19FE10FE12FE134E19FE10FE12FE143E19FE10FE12F
  E172E19FE10FE12FE143E19FE10FE12FE143E19FE10FE12FE143E19FE
  10FE12FE172E19FE10FE12FE1F2E19FE10FE12FE10FE172E10FE12FE1
  43E19FE10FE12FE172E19FE10FE12FE134E19FE10FE12FE134E19F"
  ```
  """
  def cipher(string,salt \\ 1) do
    EtsUtil.new(:apollo18_cipher)
    salt = cond do
      (salt >= 1) -> salt
      true -> 1
    end
    result = cipher_salt(string,salt,0)
    EtsUtil.delete(:apollo18_cipher)
    result
  end
  
  
  
  @doc """
  Decipher a previously ciphered string that contains a text/string object.
  
  Should be used the same ```salt``` value used to call cipher function.
  
  ## Examples
    
  ```elixir
  iex > Apollo18.Cipher.decipher("78DA313F41504100413031EF5209525B526A5237522B526A")
  "mytext"
  ```
  ```elixir
  iex > Apollo18.Cipher.decipher("00000100313F4130415041304120F18BF1DDF1ECF1B9F1ADF1EC")
  "mytext"
  ```
  ```elixir
  iex > Apollo18.Cipher.decipher("D0CF11E0A1B11AE14129415031FF31FF4100526052B252C1429E528252C1")
  "mytext"
  ```
  """
  def decipher(string,salt \\ 1) do
    EtsUtil.new(:apollo18_cipher)
    salt = cond do
      (salt >= 1) -> salt
      true -> 1
    end
    decipher_salt(string,salt,0)
  end



  defp cipher_salt(string,salt,count) do
    cond do
      (count >= salt) -> string
      true -> cipher_salt_cipher(string) |> cipher_salt(salt,count + 1)
    end
  end
  
  
  
  defp cipher_salt_cipher(string) do
    valid_chars = valid_chars()
    chars = String.graphemes(string)
    sum = :rand.uniform(9999 - length(valid_chars))
    sum_chars = sum |> StringUtil.left_zeros(4) |> String.graphemes()
    header = cipher_chars(sum_chars,[],["0","1","2","3","4","5","6","7","8","9"],0,4,@factor) |> IO.iodata_to_binary()
    body = cipher_chars(chars,[],valid_chars,0,length(chars),sum) |> IO.iodata_to_binary()
    [Enum.random(@rand_headers),header,body] |> IO.iodata_to_binary()
  end
  
  
  
  defp decipher_salt(string,salt,count) do
    cond do
      (count >= salt) -> string
      true -> decipher_salt_decipher(string) |> decipher_salt(salt,count + 1)
    end
  end
  
  
  
  defp decipher_salt_decipher(string) do
    string = clear_one_header(@rand_headers,string)
    header = String.slice(string,0..15)
    header_a = String.slice(header,0..3) |> extract_value_from_string_char()
    header_b = String.slice(header,4..7) |> extract_value_from_string_char()
    header_c = String.slice(header,8..11) |> extract_value_from_string_char()
    header_d = String.slice(header,12..15) |> extract_value_from_string_char()
    body = String.slice(string,16..String.length(string))
    sum = "#{header_a - @factor}#{header_b - @factor}#{header_c - @factor}#{header_d - @factor}" 
             |> NumberUtil.to_integer()
    body_array = body |> String.codepoints() |> Enum.chunk_every(4) |> Enum.map(&Enum.join/1)
    decipher_chars(body_array,valid_chars(),sum)
  end

  
  
  defp cipher_chars(chars,new_chars,valid_chars,count,max,sum) do
    cond do
      (count >= max) -> new_chars |> Enum.reverse()
      true -> add_if_valid(chars,new_chars,valid_chars,count,max,sum)
    end
  end


  
  defp add_if_valid(chars,new_chars,valid_chars,count,max,sum) do
    char = chars |> hd()
    cond do
      (!(Enum.member?(valid_chars,char))) -> cipher_chars(chars |> tl(),new_chars,valid_chars,count + 1,max,sum)
      true -> cipher_chars(chars |> tl(),[cipher_char(valid_chars,char,sum) | new_chars],
                           valid_chars,count + 1,max,sum)
    end
  end


  
  defp cipher_char(valid_chars,char,sum) do
    cached_value = EtsUtil.read_from_cache(:apollo18_cipher,"ciphered_#{char}_#{sum}")
    cond do
      (nil != cached_value) -> cached_value
      true -> get_cipher_char_no_cache(valid_chars,char,sum) 
    end
  end
  
  
  
  defp get_cipher_char_no_cache(valid_chars,char,sum) do
    chars = (sum + get_pos_char(valid_chars,char,0))
              |> Integer.to_string(16) |> StringUtil.left_zeros(4) |> String.graphemes()
    cipher_char = [Enum.at(chars,1),Enum.at(chars,0),Enum.at(chars,3),Enum.at(chars,2)] |> IO.iodata_to_binary()
    EtsUtil.store_in_cache(:apollo18_cipher,"ciphered_#{char}_#{sum}",cipher_char)
    cipher_char
  end


  
  defp get_pos_char(valid_chars,char,count) do
    cond do
      (Enum.at(valid_chars,count) == char) -> count
      true -> get_pos_char(valid_chars,char,count + 1)
    end
  end


  
  defp clear_one_header(headers,string, count \\ 0) do
    cond do
      (count >= length(headers)) -> string
      (String.starts_with?(string,Enum.at(headers,count))) 
        -> StringUtil.replace(string,Enum.at(headers,count),"")
      true -> clear_one_header(headers,string,count + 1)
    end
  end


  
  defp decipher_chars(string_array,valid_chars,sum,deciphered_array \\ []) do
    cond do
      (nil == string_array or length(string_array) == 0) -> deciphered_array |> Enum.reverse() |> IO.iodata_to_binary()
      true -> decipher_chars(string_array |> tl(),valid_chars,sum,
                             [decipher_char(string_array |> hd(),valid_chars,sum) | deciphered_array])
    end
  end



  defp decipher_char(string_char,valid_chars,sum) do
    cached_value = EtsUtil.read_from_cache(:apollo18_cipher,["deciphered",string_char,sum])
    cond do
      (nil != cached_value) -> cached_value
      true -> decipher_char_no_cache(string_char,valid_chars,sum) 
    end
  end


  
  defp decipher_char_no_cache(string_char,valid_chars,sum) do
    deciphered_char = Enum.at(valid_chars,(extract_value_from_string_char(string_char) - sum))
    EtsUtil.store_in_cache(:apollo18_cipher,["deciphered",string_char,sum],deciphered_char)
    deciphered_char
  end


  
  defp extract_value_from_string_char(string_char) do
    chars = String.graphemes(string_char)
    [Enum.at(chars,1),Enum.at(chars,0),Enum.at(chars,3),Enum.at(chars,2)] 
      |> IO.iodata_to_binary() |> Integer.parse(16) |> Tuple.to_list() |> Enum.at(0)
  end


  
  defp valid_chars() do
    [
      "A","Ä","Ã","Â","Á","À","Æ","А",
      "B","Б","Ъ","Ь","Ы","C","Ç","D","Ð","Д","В","С",
      "E","Ë","Ẽ","Ê","É","È","Э","Е",
      "F","Ф","G","Г","H","Н",
      "I","Ï","Ĩ","Î","Í","Ì",
      "J","Ж","K","К","L","Л",
      "M","М","N","Ñ","И","Й",
      "O","Ö","Õ","Ô","Ó","Ò","Ѳ","О",
      "P","Р","П","Q","R","S","Ш","Щ","T","Т","Þ","Ц","Ч",
      "U","Ü","Ũ","Û","Ú","Ù",
      "V","X","Х","W",
      "Y","Ÿ","Ỹ","Ŷ","Ý","Ỳ","У",
      "Z","З",
      "ẞ","Ю","Я",
      "a","ä","ã","â","á","à","æ","а",
      "b","б","ъ","ь","ы","c","ç","d","ð","д","в","с",
      "e","ë","ẽ","ê","é","è","ə","œ","ɛ","э","е",
      "f","ф","g","г","h","н",
      "i","ï","ĩ","î","í","ì",
      "j","ж","k","к","l","л",
      "m","м","n","ñ","и","й",
      "o","ö","õ","ô","ó","ò","ѳ","о",
      "p","р","п","q","r","s","ш","щ","t","т","þ","ц","ч",
      "u","ü","ũ","û","ú","ù",
      "v","x","х","w",
      "y","ÿ","ỹ","ŷ","ý","ỳ","у",
      "z","з",
      "ß","ю","я",
      "ʃ","ʒ","ʁ","ɾ",
      "Ѣ","ѣ","Ѵ","ѵ",
      "0","1","2","3","4","5","6","7","8","9",
      " ",".",",",";",":","<",">","/","\\","?","|",
      "[","]","{","}","(",")","º","°","ª",
      "+","-","=","_","*","&","%","$","#","@",
      "~","^","´","`","‘","’","“","”",
      "!","'","\"","\n","\r","\t","\b","\f"
    ]
  end



end