﻿using OpenTK.Input;

namespace Blockland {

  public class StateGame
    : State {

    public StateGame(Window window)
      : base(window) {
    }

    public override void Start() {
      base.Start();

      mWindow.NativeWindow.KeyDown += OnEscape;
    }

    public void OnEscape(object sender, KeyboardKeyEventArgs e) {
      if (e.Key == Key.Escape)
        mWindow.Close();
    }

    public override void End() {
      base.End();
    }

  }

}