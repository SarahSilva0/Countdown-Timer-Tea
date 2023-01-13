//
//  ViewController.swift
//  countdownTeaTimer
//
//  Created by Sarah dos Santos Silva on 13/01/23.
//

import UIKit

class ViewController: UIViewController{
    
    var tea: TeaView?
    var timerTea = Timer()
    
    override func loadView() {
        self.tea = TeaView()
        self.view = self.tea
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.tea?.delegate(delegate: self)
    }
    
    @objc func countDownMethod(){

        tea?.count -= 1
        tea?.labelTimer.text = tea?.timerContFormatter()
        
        if tea?.count == 0{
            timerTea.invalidate()
            
            //MARK: ISSO NAO DEVIA TA AQUI :(
            
            tea?.cancelButton.setTitle(Bottons.end.rawValue, for: .normal)
            tea?.startButton.setTitle(Bottons.start.rawValue, for: .normal)
            tea?.startButton.backgroundColor = UIColor(red: 118/255, green: 212/255, blue: 160/255, alpha: 1.0)
            tea?.cancelButton.backgroundColor = UIColor(red: 251/255, green: 175/255, blue: 175/255, alpha: 1.0)
            tea?.startButton.isHidden = true
            tea?.labelTea.isHidden = false
        }
    }
    //MARK: SETANDO O TEMPO
    private func setTimer(){
        timerTea = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownMethod), userInfo: nil, repeats: true)
    }
    //MARK: RESETANDO O TIMER
    private func resetTimer(){
        timerTea.invalidate()
        tea?.count = 270
        tea?.labelTimer.text = tea?.timerContFormatter()
    }
}

extension ViewController: TeaViewProtocol{
    
    func actionStartButton() {
        //QUANDO O BOTAO FOR CLICADO E ESTIVER EM START, ELE VAI INICIAR O TIMER
        if tea?.startButton.currentTitle == Bottons.start.rawValue{
            setTimer()
        }

        //AQUI PAUSA O TIMER
        else{
            timerTea.invalidate()
        }
    }
    //RESETA O TIMER
    func actionCancelButton() {
       resetTimer()
    }
}


