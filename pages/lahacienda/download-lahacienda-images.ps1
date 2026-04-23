# PowerShell script to download La Hacienda product images into pages\lahacienda\
$dest = 'C:\dev\coffeeclub\pages\lahacienda\'
$urls = @{
  'brasil.jpg' = 'https://lahacienda.es/wp-content/uploads/2020/07/Brasil-scaled-e1675942262943-500x611.jpg'
  'colombia.jpg' = 'https://lahacienda.es/wp-content/uploads/2020/07/Colombia-1-scaled-e1675942039290-500x798.jpg'
  'etiopia.jpg' = 'https://lahacienda.es/wp-content/uploads/2020/07/Etiopia--scaled-e1675941633268-500x709.jpg'
  'kenia.jpg' = 'https://lahacienda.es/wp-content/uploads/2020/07/Kenia-scaled-e1675940808421-500x748.jpg'
  'mexico-descafeinado.jpeg' = 'https://lahacienda.es/wp-content/uploads/2020/07/IMG_2752-scaled-e1694621413119-500x687.jpeg'
  'ruanda.jpg' = 'https://lahacienda.es/wp-content/uploads/2021/12/Ruanda-scaled-e1675940611513-500x753.jpg'
  'peru.jpeg' = 'https://lahacienda.es/wp-content/uploads/2024/09/IMG_3626-scaled-e1725638671935-500x625.jpeg'
  'india.jpeg' = 'https://lahacienda.es/wp-content/uploads/2024/09/IMG_3627-500x889.jpeg'
}

foreach ($name in $urls.Keys) {
  $out = Join-Path $dest $name
  Write-Output "Downloading $($urls[$name]) -> $out"
  try {
    Invoke-WebRequest $urls[$name] -OutFile $out -UseBasicParsing -ErrorAction Stop
  } catch {
    Write-Warning "Failed to download $($urls[$name]): $_"
  }
}
Write-Output 'Done. Run this script locally if downloads fail here.'