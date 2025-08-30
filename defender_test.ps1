
# Os arquivos criados NÃO são maliciosos — servem apenas para benchmark.
# Lista de testes simulados (nome + conteúdo do arquivo)
$tests = @(
    @{Name="EICAR_String"; Content="X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*"}, # assinatura de teste de antivírus
    @{Name="Dummy_DLL"; Content="[DllImport(`"kernel32.dll`")] public static extern void Evil();"},        # código falso de importação de DLL
    @{Name="Base64_Shell"; Content="YmFkX2NvbW1hbmQ="}                                                     # string em base64 (texto qualquer)
)

# Array que vai armazenar os resultados
$log = @()


foreach ($t in $tests) {
    # Caminho do arquivo no diretório TEMP do usuário
    $path = "$env:TEMP\$($t.Name).txt"

    # Cria o arquivo com o conteúdo definido
    Set-Content -Path $path -Value $t.Content -Encoding ASCII

    # Espera 2 segundos para dar tempo do Defender agir (se for o caso)
    Start-Sleep -Seconds 2

    # Verifica se o arquivo ainda existe
    $exists = Test-Path $path

    # Se existe → não foi detectado; se sumiu → foi bloqueado/quarentenado
    $status = if ($exists) { "Not Detected" } else { "Quarantined/Blocked" }

    # Guarda o resultado em um objeto organizado
    $log += [PSCustomObject]@{
        Test   = $t.Name
        Path   = $path
        Status = $status
        Time   = (Get-Date)
    }
}

# Mostra os resultados em tabela no console
$log | Format-Table -AutoSize

# Exporta os resultados para um CSV em %TEMP%
$log | Export-Csv "$env:TEMP\defender_results.csv" -NoTypeInformation
