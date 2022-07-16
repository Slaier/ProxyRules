
'use strict';

const { utils } = require('surgio');

const myCommonFilter = utils.discardKeywords(['剩余流量', '过期时间', '官网', 'elegram']);

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
      name: 'direct',
      url: 'https://cdn.jsdelivr.net/gh/Hackl0us/SS-Rule-Snippet@main/Rulesets/Surge/Basic/CN.list',
    },
    {
      name: 'foreign',
      url: 'https://cdn.jsdelivr.net/gh/Hackl0us/SS-Rule-Snippet@main/Rulesets/Surge/Basic/foreign.list',
    }
  ],
  customFilters: {
    commonFilter: myCommonFilter,
  },
  artifacts: [
    /**
     * Clash
     */
    {
      name: 'Clash.yaml',
      template: 'clash',
      provider: 'provider',
      combineProviders: [ 'soCloud' ],
      customParams: {
        dns: true,
      }
    },
  ],
};
