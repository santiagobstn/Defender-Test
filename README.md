# Defender Evasion Test (Lite)

Pequeno script em **PowerShell** para testar a resposta do Windows Defender a payloads inofensivos.

## Como funciona
- Gera três arquivos de texto simulando padrões suspeitos:
  - `EICAR_String` (assinatura de teste AV)
  - `Dummy_DLL` (exemplo de import falso)
  - `Base64_Shell` (string codificada)
- Aguarda alguns segundos e verifica se o arquivo foi removido/quarentenado.
- Salva os resultados em tabela no console e exporta para `defender_results.csv`.

## Uso
.\defender_test.ps1

## Exemplo de saída
Test  	Path	Status	Time
EICAR_String	C:\Users...\EICAR_String.txt	Not Detected	29/08/2025 22:43:08
Dummy_DLL	C:\Users...\Dummy_DLL.txt	Not Detected	29/08/2025 22:43:10
Base64_Shell	C:\Users...\Base64_Shell.txt	Not Detected	29/08/2025 22:43:12
  
## ⚠️ Obs: Nenhum arquivo é malicioso. São apenas strings seguras para benchmark de antivírus.
