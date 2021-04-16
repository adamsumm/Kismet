import re


fileName = 'test.kismet_rules.swi'

#Method: translate_to_felt
#Purpose: To Translate from Kismet to ASP to Felt
def translate_to_felt(kismet_file):
    kismetModule = KismetModule(kismet_file, ['../tracery/edwardian.tracery'],
                                ignore_logit=3.0,
                                observation_temp=1.5,
                                history_cutoff=10,
                                action_budget=3,
                                default_cost=3, )
    # This makes a file called kismet_file_rules.lp
    fileName = kismet_file + '_rules.lp'
    fileToText = fileToString(fileName)
    print(parseArgument(fileToText))
    print(feltActionsConvert(whereMatch,associateActions))

#Method:fileToString(fileName)
#Purpose: Open files and return as a string
def fileToString(fileName):
    files = open(fileName, 'r').read()
    return files


#Method: translator(arr)
#Purpose: Translates different cases from Felt
def translator(arr):
    x = arr.split()
    caseStartsWithApostropheAndQuestionMark = """'?"""
    caseStartsWithQuestionMark = '?'
    caseStartsWithQuotationMark= '"'
    caseStartsWithApostropheAndParenthesis = "'("
    if(x[0].startswith(caseStartsWithApostropheAndQuestionMark) and x[2].startswith(caseStartsWithQuestionMark) and len(x)==3):
        if(x[0]=="'?affection"):
            wordOneToConvert =  x[0][2:].capitalize()
        else:
            wordOneToConvert = x[0][2:]
        wordTwoToConvert =x[1][1:len(x[1])-1]
        wordThreeToConvert = x[2][1:len(x[2])-1]
    elif(x[0].startswith(caseStartsWithApostropheAndQuestionMark) and x[len(x)-1].startswith(caseStartsWithQuotationMark) and len(x)==3):
        if (x[0] == "'?affection"):
            wordOneToConvert = x[0][2:].capitalize()
        else:
            wordOneToConvert = x[0][2:]
        wordTwoToConvert = x[1][1:len(x[1]) - 1]
        wordThreeToConvert = x[2][1:len(x[2]) - 2]
    elif(x[0].startswith(caseStartsWithApostropheAndParenthesis)):
        if("not=" in x[0]):
            wordOneToConvert = "!="
        else:
            wordOneToConvert = x[0][2:]
        wordTwoToConvert = x[1][1:]
        if(x[2].startswith("?")):
            wordThreeToConvert = x[2][1:len(x[2]) - 2]
        else:
            wordThreeToConvert=x[2][:len(x[2]) - 2]
        return f"""{wordTwoToConvert}{wordOneToConvert}{wordThreeToConvert}"""
    return f"""{wordTwoToConvert}({wordOneToConvert},{wordThreeToConvert})"""


#Method: translate(strs)
#Purpose: Translates different cases and calls translator
def translate(strs):
    x= strs.split("\\")
    for phrase in x:
        wordToConvert = phrase.split()
        if(wordToConvert[0].startswith("'(or")):
            print(translator(f"""'"{wordToConvert[1][1:]} {wordToConvert[2]} {wordToConvert[3][:-1]}"""))
        elif(wordToConvert[0].startswith("[?") and ")" in wordToConvert[len(wordToConvert)-1]):
            print(translator(f"""'"{wordToConvert[0][1:]} {wordToConvert[1]} {wordToConvert[2][:-2]}"""))
        elif (wordToConvert[0].startswith("[?")):
            print(translator(f"""'" {wordToConvert[0][1:]} {wordToConvert[1]} {wordToConvert[2][:-1]}"""))


wordBank = ["type","source","target","level","romanceTarget","name"]
functionBank = ["romanceState"]


#Method: prologue_To_Felt(toConvert):
#Purpose: Translate Prologue to Felt
def prologue_To_Felt(toConvert):
    argumentWeDoNotNeed = ['person', 'event','location','at','mode']
    if("(" in toConvert and ")" in toConvert):
        splitWordToFelt = toConvert.replace(')','')
        lhs,rhs = splitWordToFelt.split('(')
        rhs = rhs.split(',')
        rhs = [modifyArgument(argument) for argument in rhs]
        if(lhs in argumentWeDoNotNeed):
            return
        elif ('action' in lhs):
            #return modifyArgumentForRegisterAction(lhs,rhs)
            return modifyArgumentForRegisterAction(rhs)
        elif('"null"' in rhs):
            return
        elif('is' == lhs and len(rhs)>=3):
            return f"""'{rhs[1]} {rhs[0]} {rhs[2]}'"""
        elif ('is' == lhs and len(rhs) >= 2):
            return f"""'{rhs[0]} "{lhs}" {rhs[1]}'"""
        elif('different'==lhs):
            return f"""'(not= {rhs[0]} {rhs[1]})'"""
        elif('null' in rhs):
            return
        return f"""'{rhs[0]} "{lhs}" {rhs[1]}'"""
    elif ">=" in toConvert:
        splitWordToFelt = toConvert.split('>=')
        return f"""'(>= ?{splitWordToFelt[0]} {splitWordToFelt[1]})'"""
    elif "<=" in toConvert:
        splitWordToFelt = toConvert.split('<=')
        return f"""'(<= ?{splitWordToFelt[0]} {splitWordToFelt[1]})'"""
    elif ">" in toConvert:
        splitWordToFelt = toConvert.split('>')
        return f"""'(> ?{splitWordToFelt[0]} {splitWordToFelt[1]})'"""
    elif "<" in toConvert:
        splitWordToFelt = toConvert.split('<')
        return f"""'(< ?{splitWordToFelt[0]} {splitWordToFelt[1]})'"""
    elif "!=" in toConvert:
        splitWordToFelt = toConvert.split('!=')
        return f"""'(not= ?{splitWordToFelt[0]} ?{splitWordToFelt[1]})'"""
    elif "=" in toConvert:
        splitWordToFelt = toConvert.split('!=')
        return f"""'(= ?{splitWordToFelt[0]} ?{splitWordToFelt[1]})'"""


#Method: modifyArgument(argument)
#Purpose: Modifies argument that if argument[0] is upper case we add question mark
def modifyArgument(argument):
    argument = argument.rstrip().strip()
    if(argument[0].isupper()):
        return f"""?{argument.lower()}"""
    else:
        return f'''"{argument.lower()}"'''


#Method: modifyArgumentForThreeParameters(argument)
#Purpose: Modify argument for three parameters
def modifyArgumentForThreeParameters(argument):
    convertWord = argument[-1]
    convertWord = convertWord.split()
    return f"""({convertWord[1]} {convertWord[0]} {convertWord[2]})"""


#Method:modifyArgumentForRegisterAction(rhs)
#Purpose: Modifies argument for Register Action
def modifyArgumentForRegisterAction(rhs):
    return f"""{rhs[0][1:-1]}"""


#Method: parseArgument(text)
#Purpose: Parses Argument for text to help group each action
def parseArgument(text):
    start_location = 0
    stack = []
    for ind in range(len(text)):
        if(text[ind] == '.'):
            parsePhrase=text[start_location:ind]
            parsePhrase = parsePhrase.rstrip().strip()
            parsePhrase = parseArgumentToFelt(parsePhrase)
            start_location = ind+1

whereMatch = dict()
associateActions = dict()


#Method: parseArgumentToFelt(argument)
#Purpose: Parses each argument from parseArgument(text) and turns them into Felt
def parseArgumentToFelt(argument):
    wordsCantUse = ["propensity", "status", "trait"]
    stack = []
    start_location = 0;
    if( any(ele in argument for ele in wordsCantUse)== True ):
        return
    elif(('action' and ':-' in argument) and ('occurred' not in argument)):
        lhs,rhs = argument.split(':-')
        rhs = rhs.rstrip().strip()
        registerWord = prologue_To_Felt(lhs)
        assignValues(lhs,associateActions)
        for ind in range(len(rhs)):
            if(rhs[ind]=='('):
                stack.append('(')
            elif(rhs[ind]==')'):
                stack.pop()
            if((rhs[ind] == ',' and len(stack)==0) or (rhs[ind] == '.' and len(stack)==0)):
                parseArgument = rhs[start_location:ind]
                parseArgument = parseArgument.rstrip().strip()
                try:
                    argumentWord = prologue_To_Felt(parseArgument)
                    if argumentWord:
                        if registerWord not in whereMatch:
                            whereMatch[registerWord]= [argumentWord]
                        else:
                            whereMatch[registerWord].append(argumentWord)
                except:
                    print("Couldnt't parse", parseArgument)
                start_location = ind + 1
    elif(('action' and ':-' in argument) and ('occurred' in argument) and ('update' not in argument)):
        try:
            effectsConvert(argument,whereMatch)
        except:
            print("Couldn't parse", argument)
    elif('update' in argument):
        try:
            updateStatement(argument, whereMatch)
        except:
            print("Couldn't parse", argument)
    else:
        try:
            argumentWord = prologue_To_Felt(argument)

        except:
            print("Couldnt't parse", argument)


#Method: effectsConvert(argument,whereMatch):
#Purpose: Converts the "type" effects arguments
def effectsConvert(argument,whereMatch):
    effects = ''
    argument = argument.replace("("," ")
    argument = argument.replace(")", " ")
    argument = argument.replace(",", " ")
    lhs, rhs = argument.split(':-')
    rhs = rhs.replace('.', '')
    lhs = lhs.rstrip().strip()
    rhs = rhs.rstrip().strip()
    lhs = lhs.split(' ')
    rhs = rhs.split(' ')
    #whereMatch[rhs[2]].append(effects)
    if(len(lhs)==3):
        effects += f"""{{type: '{lhs[0]}Status', status: '{lhs[2]}', source: vars.{lhs[1].lower()}}}"""
    elif(len(lhs)==4):
        effects += f"""{{type: '{lhs[0]}Status', status: '{lhs[2]}', source: vars.{lhs[1].lower()}, target: vars.{lhs[3].lower()}}}"""
    whereMatch[rhs[2]].append(effects)
    return effects


#Method: assignValues(lhs,associateActions)
#Purpose: Assign values that are associated with arguments
def assignValues(lhs,associateActions):
    lhs=lhs.replace('(',' ')
    lhs = lhs.replace(')',' ')
    lhs = lhs.replace(',', '')
    lhs = lhs.rstrip().strip()
    lhs = lhs.split(' ')
    if lhs[2]:
        associateActions[lhs[1]] = ["actor: vars."+lhs[2].lower()+","]
    if "null" not in lhs[3]:
        associateActions[lhs[1]].append("target: vars."+lhs[3].lower()+",")
    if "null" not in lhs[4]:
        associateActions[lhs[1]].append("subject: vars."+lhs[4].lower()+",")
    if "null" not in lhs[5]:
        associateActions[lhs[1]].append("event: vars."+lhs[5].lower()+",")
    if "null" not in lhs[6]:
        associateActions[lhs[1]].append("location: vars."+lhs[6].lower()+",")


#Method: feltActionsConvert(whereMatch,associateActions)
#Purpose: Turns into complete Felt statement, gets values from parameters and prints out
def feltActionsConvert(whereMatch,associateActions):
    for x in whereMatch:
        felt = f"""Felt.Register('{x}',{{ """
        effects = f"""\n \teffects: [\n"""
        where = f"""\nwhere: [ \n"""
        events = f"""\nevent: (vars) => ({{ \n"""
        act = ""
        if(x in associateActions):
            act_clauses=[]
            for a in associateActions[x]:
                act_clauses.append('\t' + a)
            act = "\n".join(act_clauses)
            effects_clauses = []
            where_clauses = []
        for y in whereMatch[x]:
            if('type' in y):
                effects_clauses.append('\t' + y)
            elif(len(y)>1):
                where_clauses.append('\t' + y)
        if(len(effects_clauses)>0):
            effects += ",\n".join(effects_clauses)
            effects += "\n"
        where += ",\n".join(where_clauses)
        felt = felt+where+"\n ],"+events+act+effects+ "\t], \n}) \n });"
        print(felt)


#Method: updateStatement(argument,whereMatch)
#Purpose: Updates statements that start with update on left hand side
def updateStatement(argument,whereMatch):
    lhs, rhs = argument.split(':-')
    num = len(rhs)
    start_location =0
    list = []
    stack = []
    for ind in range(len(rhs)):
        if(rhs[ind] == '('):
            stack.append('(')
        elif(rhs[ind] == ')'):
            stack.pop()
        elif(rhs[ind] == ',' and (len(stack)==0) ):
            newArgument = rhs[start_location:ind]
            newArgument = newArgument.replace('(', ' ')
            newArgument = newArgument.replace(')', ' ')
            newArgument = newArgument.replace(',', ' ')
            newArgument = newArgument.rstrip().strip()
            list.append(newArgument)
            start_location = ind+1
        if(ind==num-1):
            newArgument = rhs[start_location:ind]
            newArgument = newArgument.replace('(', ' ')
            newArgument = newArgument.replace(')', ' ')
            newArgument = newArgument.replace(',', ' ')
            newArgument = newArgument.rstrip().strip()
            list.append(newArgument)
            start_location = ind + 1
    typeArgument = list[0].split(' ')
    amountArgument = list[1].split(' ')
    argueArgument = list[2].split(' ')
    updatedStatement = f"""{{type: 'change{typeArgument[2].capitalize()}Level', source: vars.{typeArgument[1].lower()}, target: vars.{typeArgument[3].lower()}, amount: {amountArgument[2]}}}"""
    whereMatch[argueArgument[2]].append(updatedStatement)
    return updatedStatement

# fileName = fileToString(fileName)
# print(parseArgument(fileName))
# print(feltActionsConvert(whereMatch,associateActions))
extractFile(kismetModule)





