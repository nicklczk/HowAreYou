class Survey {
    
    let title : String
    let questions : [String] //let array because it shouldn't need to be mutable
    var answers : [Int] //var array so it can be updated
    
    init (withTitle: String, withQuestions: [String]){
        title = withTitle
        questions = withQuestions
        answers = Array(repeating: 0, count: questions.count)
    }
    
    //Remember that if needed, we can subclass this at some point in the future.
    
}
