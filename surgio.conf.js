
'use strict';

const { utils } = require('surgio');

const myCommonFilter = utils.discardKeywords(['剩余流量', '过期时间', '官网', 'elegram']);
const myNhkFilter = utils.mergeFilters([utils.discardKeywords(['hkt', 'HKT', '香港']), myCommonFilter], true);
const myCheapFilter = utils.mergeFilters([utils.discardKeywords(['6x']), myCommonFilter], true);

/**
 * 使用文档：https://surgio.royli.dev/
 */
module.exports = {
  /**
   * 远程片段
   * 文档：https://surgio.royli.dev/guide/custom-config.html#remotesnippets
   */
  remoteSnippets: [
    {
      name: 'reject',
      url: 'https://raw.githubusercontent.com/Loyalsoldier/surge-rules/release/ruleset/reject.txt'
    },
    {
      name: 'gfw',
      url: 'https://raw.githubusercontent.com/Loyalsoldier/surge-rules/release/ruleset/gfw.txt'
    },
    {
      name: 'greatfire',
      url: 'https://raw.githubusercontent.com/Loyalsoldier/surge-rules/release/ruleset/greatfire.txt'
    },
    {
      name: 'twitter',
      url: 'https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Extra/Twitter.list',
    },
    {
      name: 'telegram',
      url: 'https://raw.githubusercontent.com/Loyalsoldier/surge-rules/release/ruleset/telegramcidr.txt'
    },
    {
      name: 'direct',
      url: 'https://raw.githubusercontent.com/Loyalsoldier/surge-rules/release/ruleset/direct.txt',
    },
  ],
  customFilters: {
    commonFilter: myCommonFilter,
    nhkFilter: myNhkFilter,
    cheapFilter: myCheapFilter,
  },
  artifacts: [
    /**
     * Clash
     */
    {
      name: 'Clash.yaml',
      template: 'clash',
      provider: 'provider',
      // combineProviders: [ 'rixcloud' ],
      customParams: {
        dns: true,
      }
    },
  ],
};
