# encoding: utf-8
require 'json'
require 'octokit'
require 'open-uri'
require 'yaml'

buildpacks_ci_dir = File.expand_path(File.join(File.dirname(__FILE__), '..'))
require "#{buildpacks_ci_dir}/lib/slack-client"
require "#{buildpacks_ci_dir}/lib/tracker-client"
require "#{buildpacks_ci_dir}/lib/buildpack-dependency"

class DependencyUpdateDetector

  def initialize(new_releases_dir)
    @new_releases_dir = new_releases_dir
    # read dependecies/main.yml ['tools'] 
    # create a dependency model list
  end

  def check_updates
    # itereate from all dependencies and fetch their actual versions
  end

  private

  def dependencies
    Octokit.auto_paginate = true
    Octokit.configure do |c|
      c.login    = ENV.fetch('GITHUB_USERNAME')
      c.password = ENV.fetch('GITHUB_PASSWORD')
    end
  end

end