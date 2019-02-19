class Survey {
    //Remember that if needed, we can subclass this at some point in the future.
    let title : String
    let questions : [String] //let array because it shouldn't need to be mutable
    var answers : [Int] //var array so it can be updated
    
    init (withTitle: String, withQuestions: [String]){
        title = withTitle
        questions = withQuestions
        answers = Array(repeating: 0, count: questions.count)
    }
    
    /*
     *Returns the sum of the answers array.
     *Swift has this nifty feature: calculated properties.
     *In essence, it's a returning function call that looks
     *like a variable.
     */
    var answersSum : Int {
        var returnValue : Int = 0;
        for i in 0..<questions.count {
            returnValue += answers[i]
        }
        return returnValue
    }
    
    
}
