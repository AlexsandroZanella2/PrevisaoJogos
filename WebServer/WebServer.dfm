object WebModule1: TWebModule1
  OldCreateOrder = False
  Actions = <
    item
      Default = True
      Name = 'UserLogin'
      PathInfo = '/UserLogin.cjp'
      OnAction = WebModule1UserLoginAction
    end
    item
      Name = 'UserRegister'
      PathInfo = '/UserRegister.cjp'
      OnAction = WebModule1UserRegisterAction
    end
    item
      Name = 'GetJogosPassados'
      PathInfo = '/JogosPassados.cjp'
      OnAction = WebModule1GetJogosPassadosAction
    end
    item
      Name = 'GetJogosAtuais'
      PathInfo = '/JogosAtuais.cjp'
      OnAction = WebModule1GetJogosAtuaisAction
    end
    item
      Name = 'GetJogosFuturos'
      PathInfo = '/JogosFuturos.cjp'
      OnAction = WebModule1GetJogosFuturosAction
    end>
  Height = 230
  Width = 415
  object RESTClient1: TRESTClient
    Params = <
      item
      end>
    Left = 224
    Top = 56
  end
  object RESTResponse1: TRESTResponse
    Left = 304
    Top = 64
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 144
    Top = 72
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    FieldDefs = <>
    Left = 240
    Top = 128
  end
end
