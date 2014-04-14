learning_patterns = 
  'not': [
    [[1, 1], 0],
    [[1, 0], 0],
    [[0, 1], 0],
    [[0, 0], 1]]
  'and':[
    [[1, 1], 1],
    [[1, 0], 0],
    [[0, 1], 0],
    [[0, 0], 0]]
  'or': [
    [[1, 1], 1],
    [[1, 0], 1],
    [[0, 1], 1],
    [[0, 0], 0]]
  exclusive_or: [
    [[1, 1], 0],
    [[1, 0], 1],
    [[0, 1], 1],
    [[0, 0], 0]]

perceptron = new MLPerceptron()

perceptron.learn learning_patterns.exclusive_or

console.log perceptron.calc [0, 0]
console.log perceptron.calc [0, 1]
console.log perceptron.calc [1, 0]
console.log perceptron.calc [1, 1]