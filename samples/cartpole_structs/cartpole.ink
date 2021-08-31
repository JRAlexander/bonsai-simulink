# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

inkling "2.0"

using Math
using Goal

# thresholds
const PositionThreshold = 4.0
const AngleThreshold = 0.26

type SimState {
    myArray:number[5],
    cart: {
        position: number,
        velocity: number,
    },
    pole: {
        angle: number,
        rotation: number,
    }
}

type Action {
    command: number<-10,10,>
}

type CartPoleConfig {
    pos: number
}

function Reward(obs: SimState) {
    if FellOver(obs) or OutOfRange(obs) {
        return 0
    }
    return 1
}

function Terminal(obs: SimState) {
    return FellOver(obs) or OutOfRange(obs)
}

function FellOver(obs: SimState) {
    return Math.Abs(obs.pole.angle) > AngleThreshold
}

function OutOfRange(obs: SimState) {
    return Math.Abs(obs.cart.position) > PositionThreshold
}

simulator CartpoleSimulator(action: Action, config: CartPoleConfig): SimState {
}

graph (input: SimState): Action {
    concept balance(input): Action {
        curriculum {
            source CartpoleSimulator
            reward Reward
            terminal Terminal
            lesson balancing {
                scenario {
                    pos: 0
                }
            }
        }
    }
    output balance
}
