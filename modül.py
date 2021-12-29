from proje import Dil_kontrol,SifrelemeYontemleri,Help
import os
try:
    getFolder = os.path.dirname(os.path.abspath(__file__))
    mainFile = os.path.join(getFolder, 'yaz.txt') 
    file = open(mainFile,encoding='utf-8')
    line = file.read()
    file.close()
except (FileNotFoundError):
    print('böyle bir dosya bulunamadı lütfen geçerli bir dosya ismi giriniz')
asd=Dil_kontrol(line)
print(asd.BuyukUnlu_Uyumu())
sifreleme=SifrelemeYontemleri(line)
sifreleme.sha256()
