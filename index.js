const agent = require('superagent')
const cheerio = require('cheerio')
const async = require('async')
const path = require('path')
const fs = require('fs')

const HOST = 'http://tl.cyg.changyou.com/goods/selling'
const LIST_SELECTOR = '#J_good_list .title a'
console.log('爬虫程序开始运行......')

const loadRoleList = function (url, callback) {
    agent.get(url).end(function (err, res) {
        const html = res.text
        const $ = cheerio.load(html)
        const listDom = $(LIST_SELECTOR)
        const urls = []
        Object.keys(listDom).forEach(v => {
            parseInt(v) >= 0 ? urls.push(listDom[v].attribs.href) : null
        })
        callback(urls)
    })
}

const loadRoleInfo = function (url, callback) {
    agent.get(url).end(function (err, res) {
        callback(res.text)
    })
}

const filterRole = function (keywords) {

}

const createFolder = function(to) {
    const sep = path.sep
    const folders = path.dirname(to).split(sep);
    let p = '';
    while (folders.length) {
        p += folders.shift() + sep;
        if (!fs.existsSync(p)) {
            fs.mkdirSync(p);
        }
    }
};
const saveToJSONFile = function (url) {
    const template = ''
    const fileName = './database/role.txt'
    createFolder(fileName)
    const readStream = fs.createReadStream(fileName)
    const writeStream = fs.createWriteStream(fileName)
    readStream.on('data',function (data) {
        console.log(data)
    })

    // file.write(url)
}

saveToJSONFile('dddd')
// saveToJSONFile('sss')