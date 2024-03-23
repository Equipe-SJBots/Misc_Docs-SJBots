unit RcCalcC;

interface

const
  LangPack: array [0..82,0..2] of string=
 (('Languages', 'Portugu�s', 'English')
 ,('Erro', 'Erro', 'Error')
 ,('ErroNACA1', 'Os NACA de 5 d�gitos devem come�ar em 210,220,230,240 ou 250',
                '5-digit NACA airfoils must start with 210,220,230,240 ou 250')
 ,('ErroNACA2', 'Os perfis NACA devem ter at� 5 d�gitos', 'NACA airfoils must be up to 5 digits')
 ,('ErroNACA3', 'N�mero inv�lido', 'Invalid number')
 ,('LowPitch', 'Velocidade do fluxo de ar da h�lice insuficiente!', 'Pitch-speed is too low')
 ,('AboutTitle', 'Sobre', 'About')
 ,('AboutText', 'RCcalc 1.1 '#13#13+
                'RCcalc foi criado por Alexandre Magalhaes para auxiliar na '+
                'previs�o das caracter�sticas de v�o de aeromodelos el�tricos. '#13#13+
                'Perguntas e sugest�es podem ser enviadas no www.RCgroups.com ou '+
                'www.e-voo.com (mensagem particular para usu�rio alexcmag).'#13#13+
                'Visite nosso site e f�rum sobre aeromodelismo el�trico: www.e-voo.com '#13#13+
                'Este � um freeware oferecido para servir como ferramenta de c�lculo para '+
                'auxiliar no projeto de aeromodelos el�tricos, o autor n�o se responsabiliza '+
                'sobre os resultados obtidos.',
                'RCcalc 1.1'#13#13+
                'RCcalc was created by Alexandre Magalhaes to help predicting the flight '+
                'of electric aircraft models.'#13#13+
                'Questions and suggestions can be made on www.RCgroups.com or '+
                'www.e-voo.com (private message to user alexcmag).'#13#13+
                'Visit our electric model airplane web site and forum: www.e-voo.com'#13#13+
                'This software is a freeware provided "as is" free of charges to help simple '+
                'calculations on aircraft model project and building.'#13#13+
                'The author make no warranties of results of using it')
 ,('Thrust1', 'Empuxo insuficiente para v�o motorizado',              'Thrust is too low, will not fly') ,('Thrust2', 'Pouco empuxo.  Suficiente apenas para modelos eficientes.',              'Very low thrust.  Model must be very efficient.') ,('Thrust3', 'Empuxo cr�tico, cuidado com a aerodin�mica.',              'Low thrust, must have a low drag model airplane') ,('Thrust5', '�timo empuxo, pot�ncia de sobra para abusar.',              'Excelent thrust, power for a lot of fun') ,('Thrust4', 'Bom empuxo, suficiente para a maioria dos modelos',              'Good thrust, enough for most models') ,('Thrust6', 'At� tampa de privada voa.', 'Even a flat plate can fly with this thrust') ,('Thrust7', 'At� tijolo voa.', 'Even a rock can fly with so much thrust') ,('Thrust8', 'Foguete bal�stico.', 'Rocket.')
 ,('Thrust9', 'Cole bem o motor para n�o sair voando sem o avi�o.',
              'Motor can fly away without the model airplane')
 ,('Label1', 'Envergadura', 'Wingspan')
 ,('Label2', 'Corda m�dia', 'Avg. chord')
 ,('Label4', 'Reynolds', 'Reynolds')
 ,('Label5', 'cm', 'cm'),('Label6', 'cm', 'cm')
 ,('Label8', 'Peso', 'Weight')
 ,('Label9', 'g', 'g'),('Label10', '�rea de asa', 'Wing area')
 ,('Label11', 'Carga alar', 'Wing load')
 ,('Label12', 'g/dm�', 'g/dm�')
 ,('Label13', 'dm�', 'dm�')
 ,('Label14', 'Vel. stall', 'Stall speed'),('Label15', 'Vel. planeio', 'Best soaring')
 ,('Label16', 'm/s', 'm/s')
 ,('Label17', 'm/s', 'm/s')
 ,('Label20', 'Km/h', 'Km/h')
 ,('Label21', 'Km/h', 'Km/h')
 ,('Label7', 'g', 'g')
 ,('Label18', 'g', 'g')
 ,('Label19', 'Incid�ncia', 'Incidence')
 ,('Label31', 'Vel. segura', 'Safe speed')
 ,('Label32', 'm/s', 'm/s')
 ,('Label33', 'Km/h', 'Km/h')
 ,('Label34', 'g', 'g')
 ,('Label38', 'Vel. c�lculo', 'Calc speed')
 ,('Label39', 'm/s', 'm/s')
 ,('Label40', 'Km/h', 'Km/h'),('Label41', 'g', 'g')
 ,('Label3', 'Polar', 'Polar')
 ,('Label23', 'Perfil', 'Airfoil')
 ,('Label25', 'H�lice', 'Propeller')
 ,('Label24', 'Rota��o', 'Speed')
 ,('Label26', 'g', 'g')
 ,('Label27', 'Pitch-speed', 'Pitch-speed')
 ,('Label28', 'm/s', 'm/s')
 ,('Label29', 'Km/h', 'Km/h')
 ,('Label30', 'Empuxo', 'Thrust')
 ,('Label35', 'Di�metro', 'Diameter')
 ,('Label36', 'Passo', 'Pitch')
 ,('Label37', '%', '%')
 ,('Arquivo1', 'Arquivo', 'File')
 ,('Sair1', 'Sair', 'Quit')
 ,('Perfil1', 'Perfil', 'Airfoil')
 ,('Importar1', 'Importar', 'Import')
 ,('Label22', 'Arrasto', 'Drag')
 ,('Language1', 'Language', 'Language')
 ,('Portuguese1', 'Portugu�s', 'Portugu�s')
 ,('English1', 'English', 'English')
 ,('Label42', 'pol.', 'in.')
 ,('GerarNACA1', 'Gerar NACA', 'Make NACA airfoil')
 ,('Ajuda1', 'Ajuda', 'Help')
 ,('Sobre1', 'Sobre', 'About')
 ,('Label43', 'Watts', 'Watts')
 ,('Label44', 'Pot�ncia de sa�da', 'Output power')
 ,('Label45', 'Quantidade', 'Quantity')
 ,('Label46', 'motores', 'motors')
   ,('Label47', 'Sugest�o de motores', 'Motor suggestion')
   ,('Label49', 'Clique duplo em um dos motores acima para selecionar seus dados', 'Double-click a motor to select its data')
   ,('Label48', 'Tipo de v�o', 'Model type')
   ,('Label50', 'Avisos', 'Warnings')
   ,('MsgFastSlowflyer', 'Muito r�pido para slowflyer', 'Too fast for SlowFlyear')
   ,('MsgFastTrainer'  , 'Muito r�pido para treinador', 'Too fast for a trainer')
   ,('Abrir1', 'Abrir', 'Open')
   ,('Salvar1', 'Salvar', 'Save')
   ,('N1', '-', '-')
   ,('Label51', 'Nome do modelo', 'Model name')
);


implementation

end.
