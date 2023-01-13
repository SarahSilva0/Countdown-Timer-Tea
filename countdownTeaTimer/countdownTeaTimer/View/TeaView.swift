//
//  TeaView.swift
//  countdownTeaTimer
//
//  Created by Sarah dos Santos Silva on 13/01/23.
//

import UIKit

//MARK: CRIANDO OS DELEGATES QUE SERAO USADOS PARA COMUNICAR A ACAO ENTRE AS VIEWS
protocol TeaViewProtocol: AnyObject{
    func actionStartButton()
    func actionCancelButton()
}

class TeaView: UIView {
    
    //MARK: CRIANDO O DELEGATE
    private weak var delegate: TeaViewProtocol?
    
    //MARK: ISSO PODERIA IR PARA DENTRO DO PROTOCOL, TALVEZ.
    public var count: Int = 270
    
    //MARK: CRIANDO A FUNC DO DELEGATE PARA SER ASSINADA NA VIEW CONTROLLER
    func delegate(delegate:TeaViewProtocol?){
        self.delegate = delegate
    }
    
    //MARK: Criando os elementos:
    
    lazy var teaImage: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "tea")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var labelTimer: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 60)
        label.text = timerContFormatter()
        return label
    }()
    
    lazy var labelTea: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 50)
        label.text = "TEA TIME!"
        label.isHidden = true
        return label
    }()
    
    lazy var startButton: UIButton = {
        let botao = UIButton()
        botao.translatesAutoresizingMaskIntoConstraints = false
        botao.setTitle(Bottons.start.rawValue, for: .normal)
        botao.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        botao.setTitleColor(.black, for: .normal)
        botao.layer.cornerRadius = 25.0
        botao.backgroundColor = .init(red: 118/255, green: 212/255, blue: 159/255, alpha: 1.0)
        botao.addTarget(self, action: #selector(self.tappedStartButton), for: .touchUpInside)
        return botao
    }()
    
    lazy var cancelButton: UIButton = {
        let botao = UIButton()
        botao.translatesAutoresizingMaskIntoConstraints = false
        botao.setTitle(Bottons.cancel.rawValue, for: .normal)
        botao.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        botao.setTitleColor(.black, for: .normal)
        botao.layer.cornerRadius = 25.0
        botao.backgroundColor = .init(red: 242/255, green: 226/255, blue: 227/255, alpha: 1.0)
        botao.addTarget(self, action: #selector(self.tappedCancelButton), for: .touchUpInside)
        return botao
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubViews()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews(){
        self.addSubview(self.teaImage)
        self.addSubview(self.labelTimer)
        self.addSubview(self.startButton)
        self.addSubview(self.cancelButton)
        self.addSubview(self.labelTea)
    }
    
    @objc private func tappedStartButton(){
        self.delegate?.actionStartButton()
        startActionStyle()
    }
    
    //MARK: MELHORAR ISSO DEPOIS, AINDA TEM MUITA COISA AQUI DENTRO.
    
    @objc private func tappedCancelButton(){
        
        self.delegate?.actionCancelButton()
        cancelInteractsStart()
        self.cancelButton.setTitle(Bottons.cancel.rawValue, for: .normal)
        self.cancelButton.backgroundColor = .init(red: 242/255, green: 226/255, blue: 227/255, alpha: 1.0)
        self.labelTea.isHidden = true
        self.startButton.isHidden = false
        
    }
    //MARK: FORMATANDO O INT PARA MINUTOS E SEGUNDOS
    public func timerContFormatter() -> String?{
        let formatter = DateComponentsFormatter ()
        formatter.allowedUnits = [.minute, .second]
        let formattedString = formatter.string(from: TimeInterval (count))
        return formattedString!
    }
    
    //MARK: QUANDO EU CLICAR NO BOTAO DE START, SE FOR START MUDA PARA PAUSA E SE FOR PAUSA MUDA PARA START
    
    private func startActionStyle(){
        
        switch startButton.currentTitle {
            
        case Bottons.start.rawValue:
            self.startButton.setTitle(Bottons.pause.rawValue, for: .normal)
            self.startButton.backgroundColor = .init(red: 233/255, green: 203/255, blue: 151/255, alpha: 1.0)
            
        case Bottons.pause.rawValue:
            self.startButton.setTitle(Bottons.start.rawValue, for: .normal)
            self.startButton.backgroundColor = .init(red: 118/255, green: 212/255, blue: 159/255, alpha: 1.0)
            
        default: break
            
        }
    }
    //MARK: TRATANDO QUANDO FOR CLICADO NO CANCELAR, O BOTÃO DE START MUDAR PARA START, CASO ESTEJA EM PAUSA.
    
    private func cancelInteractsStart(){
        
        switch startButton.currentTitle {
            
        case Bottons.pause.rawValue:
            self.startButton.setTitle(Bottons.start.rawValue, for: .normal)
            self.startButton.backgroundColor = .init(red: 118/255, green: 212/255, blue: 159/255, alpha: 1.0)
            
        default: break
            
        }
    }
    
    func configConstraints(){
        NSLayoutConstraint.activate([ self.teaImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
                                      self.teaImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                      self.teaImage.heightAnchor.constraint(equalToConstant: 300),
                                      
                                      self.labelTimer.topAnchor.constraint(equalTo: self.teaImage.bottomAnchor, constant: 20),
                                      self.labelTimer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                      
                                      self.startButton.topAnchor.constraint(equalTo: self.labelTimer.bottomAnchor, constant: 20),
                                      self.startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                      self.startButton.widthAnchor.constraint(equalToConstant: 120),
                                      self.startButton.heightAnchor.constraint(equalToConstant: 50),
                                      
                                      self.cancelButton.topAnchor.constraint(equalTo: self.startButton.bottomAnchor, constant: 10),
                                      self.cancelButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                      self.cancelButton.widthAnchor.constraint(equalToConstant: 120),
                                      self.cancelButton.heightAnchor.constraint(equalToConstant: 50),
                                      
                                      self.labelTea.topAnchor.constraint(equalTo: self.labelTimer.bottomAnchor, constant: 10),
                                      self.labelTea.bottomAnchor.constraint(equalTo: self.cancelButton.topAnchor, constant: -20),
                                      self.labelTea.centerXAnchor.constraint(equalTo: self.centerXAnchor)
                                      
                                      
                                    ])
    }
}
